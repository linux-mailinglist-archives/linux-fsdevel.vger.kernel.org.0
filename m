Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964A674102D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 13:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjF1LjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 07:39:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59740 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjF1Liz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:38:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4546B1F889;
        Wed, 28 Jun 2023 11:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687952334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaYz0RfWL4tKkVaIfRwi0SkO2qSDidhpLiN6Nrrzd58=;
        b=qJkTySOukwfsUrrcrYV6XJCZIEVqYJTySEk4/dmbSBnharGbGrsKM6RKxYP2Y+Spk5Nxf5
        Raew5mwvfoIlqdaSQqz2xk8wJtJafu5x3er6s5r9jlKnM5JNP1slPelZAh+y1uuvZmgD/M
        AgN2KbULxCY73jMLwYepsEWES0I1WQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687952334;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gaYz0RfWL4tKkVaIfRwi0SkO2qSDidhpLiN6Nrrzd58=;
        b=B23rf3/dGr8ohdTbWwcEONbM4T+RlbCFDv9efd2JhsLg7t5TXHt8XlSIYJBoyDNEAYGZIu
        3spB9gGbDICBesCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3494B138E8;
        Wed, 28 Jun 2023 11:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yovODM4bnGSSQQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 28 Jun 2023 11:38:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BDA7AA0707; Wed, 28 Jun 2023 13:38:53 +0200 (CEST)
Date:   Wed, 28 Jun 2023 13:38:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: Re: [PATCH v4 0/3] fanotify accounting for fs/splice.c
Message-ID: <20230628113853.2b67fic5nvlisx3r@quack3>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Tue 27-06-23 22:50:46, Ahelenia Ziemiańska wrote:
> Always generate modify out, access in for splice;
> this gets automatically merged with no ugly special cases.
> 
> No changes to 2/3 or 3/3.

Thanks for the patches Ahelena! The code looks fine to me but to be honest
I still have one unresolved question so let me think about it loud here for
documentation purposes :). Do we want fsnotify (any filesystem
notification framework like inotify or fanotify) to actually generate
events on FIFOs? FIFOs are virtual objects and are not part of the
filesystem as such (well, the inode itself and the name is), hence
*filesystem* notification framework does not seem like a great fit to watch
for changes or accesses there. And if we say "yes" for FIFOs, then why not
AF_UNIX sockets? Where do we draw the line? And is it all worth the
trouble?

I understand the convenience of inotify working on FIFOs for the "tail -f"
usecase but then wouldn't this better be fixed in tail(1) itself by using
epoll(7) for FIFOs which, as I've noted in my other reply, does not have
the problem that poll(2) has when there are no writers?

Another issue with FIFOs is that they do not have a concept of file
position. For hierarchical storage usecase we are introducing events that
will report file ranges being modified / accessed and officially supporting
FIFOs is one more special case to deal with.

What is supporting your changes is that fsnotify mostly works for FIFOs
already now (normal reads & writes generate notification) so splice not
working could be viewed as an inconsistency. Sockets (although they are
visible in the filesystem) cannot be open so for them the illusion of being
a file is even weaker.

So overall I guess I'm slightly in favor of making fsnotify generate events
on FIFOs even with splice, provided Amir does not see a big trouble in
supporting this with his upcoming HSM changes.

								Honza

> Ahelenia Ziemiańska (3):
>   splice: always fsnotify_access(in), fsnotify_modify(out) on success
>   splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice
>   splice: fsnotify_access(in), fsnotify_modify(out) on success in tee
> 
>  fs/splice.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> Interdiff against v3:
> diff --git a/fs/splice.c b/fs/splice.c
> index 2ecfccbda956..bdbabc2ebfff 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1184,10 +1184,6 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
>  			out->f_pos = offset;
>  		else
>  			*off_out = offset;
> -
> -		// splice_write-> already marked out
> -		// as modified via vfs_iter_write()
> -		goto noaccessout;
>  	} else if (opipe) {
>  		if (off_out)
>  			return -ESPIPE;
> @@ -1211,11 +1207,10 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
>  	} else
>  		return -EINVAL;
>  
> -	if (ret > 0)
> +	if (ret > 0) {
>  		fsnotify_modify(out);
> -noaccessout:
> -	if (ret > 0)
>  		fsnotify_access(in);
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.39.2


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
