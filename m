Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34DB5A4C0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiH2Mi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiH2Mi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:38:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED85BD74B
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 05:22:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5BF6F22CDB;
        Mon, 29 Aug 2022 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661772558;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKTSO34xK/2s5bPMDkcHOgBnBROAK8E7pSIP+Jg1TpI=;
        b=wcrBfpcm+hOrYi5HkF7XXr+LO8qWmV0ZXhOGQ1fud5NNAKg8bLHR27YxHKajukO9RVSqzv
        n2RnpgBJhAK692QcIj9QvSfrlxj2TZG3N4kP7GuhCJjRF4rS6aJ0gu2v1ATLf8BJ6q5Mk7
        TrfCubCEh7W3ZyWKaPCMfS7PQYxRx/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661772558;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKTSO34xK/2s5bPMDkcHOgBnBROAK8E7pSIP+Jg1TpI=;
        b=mH0t6BrHTCH072mHb6lpJVX31wRRPqsUB/+yAl1g7+lpce4mLERznbxqwHlPhRSMR5fa4T
        lvtICuMQODZncaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 052501352A;
        Mon, 29 Aug 2022 11:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JBgSOw2jDGMCHAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 11:29:17 +0000
Date:   Mon, 29 Aug 2022 13:29:16 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
        Martin Doucha <mdoucha@suse.cz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        automated-testing@lists.yoctoproject.org,
        Tim Bird <tim.bird@sony.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] API: tst_device: Track minimal size per filesystem
Message-ID: <YwyjDLcGzhDiWXkD@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-3-pvorel@suse.cz>
 <YwybzIVhMaCqYR/S@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwybzIVhMaCqYR/S@yuki>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Cyril,

thanks a lot for a review!

...
> > +++ b/include/tst_fs.h
...
> > +unsigned int tst_min_fs_size(long f_type)
> > +{
> > +	switch (f_type) {
> > +	case 0:

> TST_ALL_FILESYSTEMS ?

Thanks for catching this. Mistake which is a result of very late Friday night coding.

> > +		return MAX(DEV_SIZE_MB_BTRFS, DEV_SIZE_MB_DEFAULT);

> I do not think that we should harcode this here. I would be for a more
> dynamic approach, i.e. add a function into the tst_supported_fs_types.c
> that loops over supported filesystems and chooses max over the minimal
> values for all supported filesystems. That way if we run on embedded
> targets the device size will be 16MB as long as btrfs-progs is not
> installed. Also that way we can easily define minimal size for xfs 300MB
> and things will work for embedded as long as xfs-progs are not
> installed.
Correct. So the value for .all_filesystems should be maximum of supported
filesystems. The only think I don't like about it that it takes some time to
check everything (mkfs.* available ... etc), but we can't avoid it.

Is it worth to cache this value (make it static in the function) so that it's not
searched more than once?

> > +	case TST_BTRFS_MAGIC:
> > +		return DEV_SIZE_MB_BTRFS;
> > +	case TST_SQUASHFS_MAGIC:
> > +		return DEV_SIZE_MB_SQUASHFS;
> > +	default:
> > +		return DEV_SIZE_MB_DEFAULT;
> > +	}
> > +}
...
> > +++ b/lib/tst_fs_type.c
> > @@ -43,6 +43,34 @@ long tst_fs_type_(void (*cleanup)(void), const char *path)
> >  	return sbuf.f_type;
> >  }

> > +long tst_fs_name_type(const char *fs)
> > +{
> > +	if (!strcmp(fs, "btrfs"))
> > +		return TST_BTRFS_MAGIC;
> > +	else if (!strcmp(fs, "exfat"))
> > +		return TST_EXFAT_MAGIC;
> > +	else if (!strcmp(fs, "ext2"))
> > +		return TST_EXT2_OLD_MAGIC;

> I'm not sure that this is a correct mapping, I think that all ext
> filesystems goes by EXT234_MAGIC these days.
OK, I'll dig into kernel's fs/ext{2,4}/
The problem is, that we still theoretically support kernel 3.0,
thus old kernels are likely using this approach and newer not.
Let's see if and when it was changed.

Kind regards,
Petr
