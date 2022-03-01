Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544874C8698
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 09:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiCAIfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 03:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiCAIfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:35:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B588163BE7;
        Tue,  1 Mar 2022 00:35:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47020B817C1;
        Tue,  1 Mar 2022 08:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE9AC340EE;
        Tue,  1 Mar 2022 08:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646123699;
        bh=5Xklv0cLK0GdlVFhbNsPD9P+D1oYr0QR/N2h+ojqkoc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZAYdRIsJgIKcc/JFxiUrxwR+fnyf+talltJN5ymyabdoWZ6CYy6yTlT5YIPMa9bEu
         Z9skfUzNEviZ1NrSzpECr/VcdxxHpKyHN2GsBhTJAV5cmnSmSfniqJ20DCJfJZTbE2
         islRPKg1Y/SelG4WvXkrJSAxuR4aBht1AH4gK3XjoI4yDDOVis/YRi13nJvM94uhAZ
         54/XIs/3jj4aBOFBwxqlIybQFm4jGmXKPGydTYwZkRlyHINOUx5NSqfOavgVflQkUI
         1zDFKWVgFSg3q25kZguyW2qBxL7L5Ip2KzSuwBtbgn2/ZIYtf4LbSU+yGrYG/0lhO/
         pAKUDbsMaUlSA==
Received: by mail-wm1-f49.google.com with SMTP id l2-20020a7bc342000000b0037fa585de26so626334wmj.1;
        Tue, 01 Mar 2022 00:34:59 -0800 (PST)
X-Gm-Message-State: AOAM531HkN0K8+OYhOac2BuMkIj6ofB3dP3TbWJw+6bIerYmkxx1hKHm
        JApnYxevM5MDzpHCKQFsX6Fhgc1EDVezpf2m6/U=
X-Google-Smtp-Source: ABdhPJznfnt4qRoVXxZVgvPQwUSYOc43dCMfq5XyQkkEUIRS5cmuwSvm5PQHgdxy0t6XmAmdDEuR0uTdr2RLlB2jT+E=
X-Received: by 2002:a7b:c001:0:b0:37d:409d:624d with SMTP id
 c1-20020a7bc001000000b0037d409d624dmr16062747wmb.64.1646123698077; Tue, 01
 Mar 2022 00:34:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:4e02:0:0:0:0:0 with HTTP; Tue, 1 Mar 2022 00:34:57 -0800 (PST)
In-Reply-To: <Yh2dqrb6SrOlWL9t@google.com>
References: <20220228234833.10434-1-linkinjeon@kernel.org> <20220228234833.10434-2-linkinjeon@kernel.org>
 <Yh2dqrb6SrOlWL9t@google.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 1 Mar 2022 17:34:57 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-XKnNH264M+K91ecUXp7vKsPfxteBv98Ot8455dGQYPw@mail.gmail.com>
Message-ID: <CAKYAXd-XKnNH264M+K91ecUXp7vKsPfxteBv98Ot8455dGQYPw@mail.gmail.com>
Subject: Re: [PATCH 2/4] ksmbd: remove filename in ksmbd_file
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        smfrench@gmail.com, hyc.lee@gmail.com,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-03-01 13:14 GMT+09:00, Sergey Senozhatsky <senozhatsky@chromium.org>:
> On (22/03/01 08:48), Namjae Jeon wrote:
>> -char *convert_to_nt_pathname(char *filename)
>> +char *convert_to_nt_pathname(struct ksmbd_share_config *share,
>> +			     struct path *path)
>>  {
>> -	char *ab_pathname;
>> +	char *pathname, *ab_pathname, *nt_pathname = NULL;
>> +	int share_path_len = strlen(share->path);
>>
>> -	if (strlen(filename) == 0)
>> -		filename = "\\";
>> +	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
>> +	if (!pathname)
>> +		return ERR_PTR(-EACCES);
>>
>> -	ab_pathname = kstrdup(filename, GFP_KERNEL);
>> -	if (!ab_pathname)
>> -		return NULL;
>> +	ab_pathname = d_path(path, pathname, PATH_MAX);
>> +	if (IS_ERR(ab_pathname)) {
>> +		nt_pathname = ERR_PTR(-EACCES);
>> +		goto free_pathname;
>> +	}
>> +
>> +	if (strncmp(ab_pathname, share->path, share_path_len)) {
>> +		nt_pathname = ERR_PTR(-EACCES);
>> +		goto free_pathname;
>> +	}
>> +
>> +	nt_pathname = kzalloc(strlen(&ab_pathname[share_path_len]) + 1,
>> GFP_KERNEL);
>> +	if (!nt_pathname) {
>> +		nt_pathname = ERR_PTR(-ENOMEM);
>> +		goto free_pathname;
>> +	}
>> +	if (ab_pathname[share_path_len] == '\0')
>> +		strcpy(nt_pathname, "/");
>> +	strcat(nt_pathname, &ab_pathname[share_path_len]);
>> +
>> +	ksmbd_conv_path_to_windows(nt_pathname);
>>
>> -	ksmbd_conv_path_to_windows(ab_pathname);
>> -	return ab_pathname;
>> +free_pathname:
>> +	kfree(pathname);
>> +	return nt_pathname;
>>  }
>
> convert_to_nt_pathname() can return NULL
I can not find where this function return NULL.. Initializing NULL for
nt_pathname is unnecessary.

>
>> +	filename = convert_to_nt_pathname(work->tcon->share_conf,
>> &fp->filp->f_path);
>> +	if (IS_ERR(filename))
>> +		return PTR_ERR(filename);
>
> I don't think this will catch NULL nt_pathname return.
>
