Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659894EED97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 14:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346053AbiDAM7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 08:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346045AbiDAM7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B93279727;
        Fri,  1 Apr 2022 05:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 144EC61A24;
        Fri,  1 Apr 2022 12:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75656C340EC;
        Fri,  1 Apr 2022 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648817870;
        bh=SPrhf2bVEi/6vQbnB5Pouibt1P7dIQ/CyWTlONOSVWU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=uK6CGH4P+acUiNdRe0aMKstxYuluknO0/KVTzTbkEqPi9Yxm20U4NSgyaseqkeMWP
         qWAXBKzQ+GELcZVhGg0ohVvdxj/rU5LFWp64dqcYyNNje25Pkt+LxCCQwWv3oIBSnI
         cVXCeGHR7bG/J3Gfkye9d2Sw3WgFPQlxsbWNWEPqi+CBaUmHRx6WQXNW7i7ZsYlP42
         ST45Mna1vNdIP9vMHvxXGgxKc9r+F9qyknAiA5Xr8M+bteK7MEtyX1RlRxUX2g3urK
         TOiKAE3fNDlP2WOhO92pBHgkp+Mu/doyXMsJXdy02Sc0gbXA4Ehs2foyvFjrpYT1Pa
         8JGHFDwFKuHKw==
Received: by mail-wr1-f54.google.com with SMTP id r13so4114453wrr.9;
        Fri, 01 Apr 2022 05:57:50 -0700 (PDT)
X-Gm-Message-State: AOAM531cxjm7MvFyqZQ9wFJ6h0x/5AdBv4MkHbH58IRaCMshqKWURJDL
        +ezcYj9fyyY7g1QWRA84HrPY1wvA+9l78eoP7rk=
X-Google-Smtp-Source: ABdhPJwmmS224z69wF0qMv7qc+oXrVWMdty+b2wHIJB37WH8O0QXFvSRBJuYc56S7ozhAmHnzouqwTh0NKjoomsee2g=
X-Received: by 2002:a5d:47a5:0:b0:203:d4fd:4653 with SMTP id
 5-20020a5d47a5000000b00203d4fd4653mr7912969wrb.229.1648817868715; Fri, 01 Apr
 2022 05:57:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c1:0:0:0:0 with HTTP; Fri, 1 Apr 2022 05:57:48
 -0700 (PDT)
In-Reply-To: <818b01d845b4$07f97b50$17ec71f0$@samsung.com>
References: <CGME20220325094234epcas1p28605e75eef8d46f614ff11f98e5a6ef8@epcas1p2.samsung.com>
 <HK2PR04MB38911DEEC1C24C06E4C272D5811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <818b01d845b4$07f97b50$17ec71f0$@samsung.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 1 Apr 2022 21:57:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8z3LE+wnQbyzwohOvy3zXwC6q50gZ8rW=ytwMae_4iOw@mail.gmail.com>
Message-ID: <CAKYAXd8z3LE+wnQbyzwohOvy3zXwC6q50gZ8rW=ytwMae_4iOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] exfat: remove exfat_update_parent_info()
To:     Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Andy Wu <Andy.Wu@sony.com>,
        Aoyama Wataru <wataru.aoyama@sony.com>,
        Daniel Palmer <daniel.palmer@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-04-01 19:34 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> exfat_update_parent_info() is a workaround for the wrong parent directory
>> information being used after renaming. Now that bug is fixed, this is no
>> longer needed, so remove it.
>>
>> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
>> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
>> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
>> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
>
> As you said, exfat_update_parent_info() seems to be a workaround
> that exists from the legacy code to resolve the inconsistency of
> parent node information.
>
> Thanks for your patch!
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Hi Yuezhang,

I don't think there's any reason to split this patch from patch 1/2.
Any thought to combine them to the one ?

Thanks.
>
>> ---
>>  fs/exfat/namei.c | 26 --------------------------
>>  1 file changed, 26 deletions(-)
>>
>> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c index
>> e7adb6bfd9d5..76acc3721951 100644
>> --- a/fs/exfat/namei.c
>> +++ b/fs/exfat/namei.c
>> @@ -1168,28 +1168,6 @@ static int exfat_move_file(struct inode *inode,
>> struct exfat_chain *p_olddir,
>>  	return 0;
>>  }
>>
>> -static void exfat_update_parent_info(struct exfat_inode_info *ei,
>> -		struct inode *parent_inode)
>> -{
>> -	struct exfat_sb_info *sbi = EXFAT_SB(parent_inode->i_sb);
>> -	struct exfat_inode_info *parent_ei = EXFAT_I(parent_inode);
>> -	loff_t parent_isize = i_size_read(parent_inode);
>> -
>> -	/*
>> -	 * the problem that struct exfat_inode_info caches wrong parent
>> info.
>> -	 *
>> -	 * because of flag-mismatch of ei->dir,
>> -	 * there is abnormal traversing cluster chain.
>> -	 */
>> -	if (unlikely(parent_ei->flags != ei->dir.flags ||
>> -		     parent_isize != EXFAT_CLU_TO_B(ei->dir.size, sbi) ||
>> -		     parent_ei->start_clu != ei->dir.dir)) {
>> -		exfat_chain_set(&ei->dir, parent_ei->start_clu,
>> -			EXFAT_B_TO_CLU_ROUND_UP(parent_isize, sbi),
>> -			parent_ei->flags);
>> -	}
>> -}
>> -
>>  /* rename or move a old file into a new file */  static int
>> __exfat_rename(struct inode *old_parent_inode,
>>  		struct exfat_inode_info *ei, struct inode *new_parent_inode,
>> @@ -1220,8 +1198,6 @@ static int __exfat_rename(struct inode
>> *old_parent_inode,
>>  		return -ENOENT;
>>  	}
>>
>> -	exfat_update_parent_info(ei, old_parent_inode);
>> -
>>  	exfat_chain_dup(&olddir, &ei->dir);
>>  	dentry = ei->entry;
>>
>> @@ -1242,8 +1218,6 @@ static int __exfat_rename(struct inode
>> *old_parent_inode,
>>  			goto out;
>>  		}
>>
>> -		exfat_update_parent_info(new_ei, new_parent_inode);
>> -
>>  		p_dir = &(new_ei->dir);
>>  		new_entry = new_ei->entry;
>>  		ep = exfat_get_dentry(sb, p_dir, new_entry, &new_bh);
>> --
>> 2.25.1
>
>
