Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F358DE48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 20:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343685AbiHISNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 14:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346054AbiHISMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:12:16 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C296220CD
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 11:05:18 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id z3so9402967qtv.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ojEQCV/0pE7IwI4Y8EDpXWBWiQ0oIulQ6mpfQVQvenk=;
        b=0rGj0tb+d4WfgCzkddJDJ2zOaPyR0l4IA5p49/7h+TACbxmxk+7lZjPwXsCiTt4aeP
         ZQnRaT9yR7vW8U/ExXn5iPlQvLp3G/dG/FZP60M8vhKMZx8BJfO2SKdnzMDWD+sQf+jx
         irHjQYu3n3d6O7YvoewTLF6CLobE56pyV2Y+KARn3tMZvderIhPB+wPWjxABw7kRiGbO
         KiYOGjkYVvCAc7QFFTDqjpwqYEWMo79p1ldeaktOGGH+I8z1m7/pNHfucdLdzrTQqILD
         JEnPUltXEwqUjPwJ8r8COFlDc4tnkhgw33K6oRZLN+nxOW+m2vqoj9c1yg4LM/5eZg/I
         ZLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ojEQCV/0pE7IwI4Y8EDpXWBWiQ0oIulQ6mpfQVQvenk=;
        b=fSmqeHmDVWF9INIT5xeLrj2J/7AVlJ3IGCCWtd3DM6pAUwobQvOwRoXy1FJyQ409JU
         LykOwLyub8KEcJqnOpzTLwzqLuyTIDtZagvmCzZ7KXJq56DLb3zv/cZ9Niag3OaH4iC6
         BhJ/ISSLeczvua/szWgBAngSAkOR9S/k2ztM1ZDayrFGDU+i2W8/lM2ODLWwpv/TCILy
         1Meth2ecZ3rsdYgAZoMlxe9oTLWM1x6uv57l+KaVRaPZ+qrzywAlN7JDKlv25ob3xiNG
         fqgfgTbQd3ObwDsCYUDY4gZpQrOvBuQmtwPjOcqwtKCKbmx3IQLXjbqhnWRjFL0SUqJl
         9vgQ==
X-Gm-Message-State: ACgBeo0dGWoKmPvRN3FgKyLTUEgOVlwrnfRIcZY70S7ayoqu90/8jnOM
        yLuND96cgdHHHUpjEaVlknKkJQ==
X-Google-Smtp-Source: AA6agR4CTAGOJKkVFFQeQ+YGH1MKJckK/ePANF7t+WaHbsh7iCeQLChmX0ZJO5D1C2Fw1HpEyMZpAA==
X-Received: by 2002:a05:622a:4c88:b0:33b:f61b:d17f with SMTP id ez8-20020a05622a4c8800b0033bf61bd17fmr21073735qtb.23.1660068315186;
        Tue, 09 Aug 2022 11:05:15 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:b19b:cbb5:a678:767c])
        by smtp.gmail.com with ESMTPSA id u33-20020a05622a19a100b00342e86b3bdasm8905881qtc.12.2022.08.09.11.05.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 11:05:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/3] hfs: Unmap the page in the "fail_page" label
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20220809152004.9223-2-fmdefrancesco@gmail.com>
Date:   Tue, 9 Aug 2022 11:05:03 -0700
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <79023F53-CAC5-4D88-B171-317B92A2EEE1@dubeyko.com>
References: <20220809152004.9223-1-fmdefrancesco@gmail.com>
 <20220809152004.9223-2-fmdefrancesco@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 9, 2022, at 8:20 AM, Fabio M. De Francesco =
<fmdefrancesco@gmail.com> wrote:
>=20
> Several paths within hfs_btree_open() jump to the "fail_page" label
> where put_page() is called while the page is still mapped.
>=20
> Call kunmap() to unmap the page soon before put_page().
>=20
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> fs/hfs/btree.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 19017d296173..56c6782436e9 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -124,6 +124,7 @@ struct hfs_btree *hfs_btree_open(struct =
super_block *sb, u32 id, btree_keycmp ke
> 	return tree;
>=20
> fail_page:
> +	kunmap(page);
> 	put_page(page);
> free_inode:
> 	tree->inode->i_mapping->a_ops =3D &hfs_aops;
> --=20
> 2.37.1
>=20


Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

