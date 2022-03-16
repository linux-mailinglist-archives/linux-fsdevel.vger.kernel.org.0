Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF3A4DAD58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 10:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354835AbiCPJVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 05:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiCPJVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:21:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41857473B1;
        Wed, 16 Mar 2022 02:20:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E6E6F1F38A;
        Wed, 16 Mar 2022 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647422429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J1NAfihEYMF6z9ZEo5teS1OwuxzjPczXcEChHxsOXas=;
        b=IqKIjfcOb8t7CQvIMvyNnF8JgkWhaCPgvXnizEuuXafPiGtJ348X21lrC27tQo/GqsoMLX
        7r8WfGk1dg0n0bSwo9cIBKCt1l3X+6DoLCP4CLZBiP42o52KTw1V6BRLTKLXJN7N8pipED
        JSh3cm8Gq/TfeI0bNMtY81t/xh9kAL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647422429;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J1NAfihEYMF6z9ZEo5teS1OwuxzjPczXcEChHxsOXas=;
        b=IqRTh9zUwLpCd4yt4hNGlViW5ipVZBtVl9JoE0M6I5ndIbCR+D+h0pHTaX3r3o21PijHXJ
        7Y09O3Oa1b45tFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A60EE13B96;
        Wed, 16 Mar 2022 09:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VNEHJ92rMWJAfAAAMHmgww
        (envelope-from <vkarasulli@suse.de>); Wed, 16 Mar 2022 09:20:29 +0000
Date:   Wed, 16 Mar 2022 10:20:28 +0100
From:   Vasant Karasulli <vkarasulli@suse.de>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ddiss@suse.de, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3 1/2] exfat: add keep_last_dots mount option
Message-ID: <YjGr3IpZ4p55YuAB@vasant-suse>
References: <20220311114746.7643-1-vkarasulli@suse.de>
 <20220311114746.7643-2-vkarasulli@suse.de>
 <CAKYAXd9kdYi4rXmyfAO3ZbmKLu3i35QzsL_oOorROYieQnWGRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9kdYi4rXmyfAO3ZbmKLu3i35QzsL_oOorROYieQnWGRg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On So 13-03-22 09:01:32, Namjae Jeon wrote:
> 2022-03-11 20:47 GMT+09:00, Vasant Karasulli <vkarasulli@suse.de>:
> > The "keep_last_dots" mount option will, in a
> > subsequent commit, control whether or not trailing periods '.' are stripped
> > from path components during file lookup or file creation.
> I don't know why the 1/2 patch should be split from the 2/2 patch.
> Wouldn't it be better to combine them? Otherwise it looks good to me.

I just followed the same patch structure as was in the initial version
of the patch.

> >
> > Suggested-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
> > Co-developed-by: David Disseldorp <ddiss@suse.de>
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> >  fs/exfat/exfat_fs.h | 3 ++-
> >  fs/exfat/super.c    | 7 +++++++
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> > index 619e5b4bed10..c6800b880920 100644
> > --- a/fs/exfat/exfat_fs.h
> > +++ b/fs/exfat/exfat_fs.h
> > @@ -203,7 +203,8 @@ struct exfat_mount_options {
> >  	/* on error: continue, panic, remount-ro */
> >  	enum exfat_error_mode errors;
> >  	unsigned utf8:1, /* Use of UTF-8 character set */
> > -		 discard:1; /* Issue discard requests on deletions */
> > +		 discard:1, /* Issue discard requests on deletions */
> > +		 keep_last_dots:1; /* Keep trailing periods in paths */
> >  	int time_offset; /* Offset of timestamps from UTC (in minutes) */
> >  };
> >
> > diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> > index 8c9fb7dcec16..4c3f80ed17b1 100644
> > --- a/fs/exfat/super.c
> > +++ b/fs/exfat/super.c
> > @@ -174,6 +174,8 @@ static int exfat_show_options(struct seq_file *m, struct
> > dentry *root)
> >  		seq_puts(m, ",errors=remount-ro");
> >  	if (opts->discard)
> >  		seq_puts(m, ",discard");
> > +	if (opts->keep_last_dots)
> > +		seq_puts(m, ",keep_last_dots");
> >  	if (opts->time_offset)
> >  		seq_printf(m, ",time_offset=%d", opts->time_offset);
> >  	return 0;
> > @@ -217,6 +219,7 @@ enum {
> >  	Opt_charset,
> >  	Opt_errors,
> >  	Opt_discard,
> > +	Opt_keep_last_dots,
> >  	Opt_time_offset,
> >
> >  	/* Deprecated options */
> > @@ -243,6 +246,7 @@ static const struct fs_parameter_spec exfat_parameters[]
> > = {
> >  	fsparam_string("iocharset",		Opt_charset),
> >  	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
> >  	fsparam_flag("discard",			Opt_discard),
> > +	fsparam_flag("keep_last_dots",		Opt_keep_last_dots),
> >  	fsparam_s32("time_offset",		Opt_time_offset),
> >  	__fsparam(NULL, "utf8",			Opt_utf8, fs_param_deprecated,
> >  		  NULL),
> > @@ -297,6 +301,9 @@ static int exfat_parse_param(struct fs_context *fc,
> > struct fs_parameter *param)
> >  	case Opt_discard:
> >  		opts->discard = 1;
> >  		break;
> > +	case Opt_keep_last_dots:
> > +		opts->keep_last_dots = 1;
> > +		break;
> >  	case Opt_time_offset:
> >  		/*
> >  		 * Make the limit 24 just in case someone invents something
> > --
> > 2.32.0
> >
> >

--
Vasant Karasulli
Kernel generalist
www.suse.com<http://www.suse.com>
[https://www.suse.com/assets/img/social-platforms-suse-logo.png]<http://www.suse.com/>
SUSE - Open Source Solutions for Enterprise Servers & Cloud<http://www.suse.com/>
Modernize your infrastructure with SUSE Linux Enterprise servers, cloud technology for IaaS, and SUSE's software-defined storage.
www.suse.com

