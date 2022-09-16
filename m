Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236555BB425
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 23:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiIPVwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 17:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIPVwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:52:34 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADCE27173
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 14:52:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 89BF63200932;
        Fri, 16 Sep 2022 17:52:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 16 Sep 2022 17:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663365149; x=
        1663451549; bh=PrECE5hLFMWoC3otYpMLa/DxKQu73f+ApoJO9zprm40=; b=k
        jyl14lUotHU/q3a87TKKL5C8XWK6VTKUwNN7UmkWQ5p8d6St6MHuNNW6JqLn1x6B
        pRiFyoPtS4RF32sFgPzm6YGEsHnkjzjYsNEkr1nCdty3j8DHp8Ga0WaR/qcYIHWi
        7MY9GAPzsobzJ60HLfstjP05vRyRQ7XT6PWmjqe5sBzpnOGlHEbwmlaZSe33vwtX
        yiWr9ytCjhq4pmgzyXYMcJtPuTLH2jfup9N6xl6ivW95Zh4W0PIIIh9DWPO4mTHK
        TlnqgJtpUZ7Fx6wpqiwnDcV/FwLnumDNV3x+otXH4hNVMyqrujqz9xxVEI7fiOQQ
        Yb7ekiG+Mc2eUCY+nlJow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663365149; x=
        1663451549; bh=PrECE5hLFMWoC3otYpMLa/DxKQu73f+ApoJO9zprm40=; b=C
        cD2FLNPC4OCWW61A//f2fNDuev15OH9vi1WMuTc3UUgGmBsHQ/Hipm6BnR5eJv3P
        Q8oick9uDo9eUm/9yo81T+BWdACo5AT+F3a7dI6GCZPnYDc6SyxjO9tdG/IOhOTt
        /JXFmca2rA7FLyIPlnzJHJek3v5BOjgtRzloQBF2bCKGySJqHgWqdB/aFquwMChO
        8OXcQI7RVQTd9aeWkiBWAhhABoO05hTGlSgkBEykth87+VrJPq+hFVHey8aIGr+D
        OOs+pw2ieQcommWivUxPJBWA18BI0Mln4Usi/8MYd9ZwY6prHlo1L8BgrgP6j59g
        lOTstrIR7FGINCNrTDy2A==
X-ME-Sender: <xms:HPAkY2y0mkRKZSvbl1e5YAgwT15QKli0r7L7VFFxsyopWDbykSXNMA>
    <xme:HPAkYyT2fXcNEg3Nfra63Q_ScywQZ4vwDfERuAXJvQUNaWyttIXx8AfqdGR0xQZAD
    sdAJDMQYtExQWKl>
X-ME-Received: <xmr:HPAkY4V9ViTUFkBxmWDwHPMXHQO_OQbfIXGBGMgZiVRAPi-x6atUyXVofJFMCPc37gJdUQFwh53PxZ-QaqSja_pKtxoELcrQHQ6ZvROE9wSqOZwGbup5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:HPAkY8hbGH8kDm3XXyl1NZmk5z-7sdR5IizqeXFwLk9F1e3ytTUSMQ>
    <xmx:HPAkY4CIeEi9iiTNggPeVGWuz4P7vQaLy8WmUoAwjM7qkkkWIa2Eyg>
    <xmx:HPAkY9K623zW_TTq-37z50BghjT7Vfwv1gWWwHGe3bSnetez4MVQtQ>
    <xmx:HfAkY36Ck-uV4NzwpxLz95g6feyyvfHn2yu4J2WRTuqHL7eugEf8Wg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Sep 2022 17:52:27 -0400 (EDT)
Message-ID: <66d2c136-547a-3538-d015-c4ee0dcb2419@fastmail.fm>
Date:   Fri, 16 Sep 2022 23:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 8/8] fuse: implement ->tmpfile()
To:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
References: <20220916194416.1657716-1-mszeredi@redhat.com>
 <20220916194416.1657716-8-mszeredi@redhat.com>
Content-Language: de-CH, en-US
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20220916194416.1657716-8-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/16/22 21:44, Miklos Szeredi wrote:


> +static int fuse_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> +			struct file *file, umode_t mode)
> +{
> +	struct fuse_conn *fc = get_fuse_conn(dir);
> +	int err;
> +
> +	if (fc->no_tmpfile)
> +		goto no_tmpfile;
> +
> +	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
> +	if (err == -ENOSYS) {
> +		fc->no_tmpfile = 1;
> +no_tmpfile:
> +		err = -EOPNOTSUPP;
> +	}
> +	return err;
> +}

A bit confusing part is that the other file systems are calling your new 
finish_tmpfile(), while fuse_create_open() calls finish_open() for 
tmpfiles as well. Seems to be identical but won't this easily miss 
possible changes done in the future to finish_tmpfile()?


Thanks,
Bernd
