Return-Path: <linux-fsdevel+bounces-22363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764D2916A11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 16:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A231C21A51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D4216B741;
	Tue, 25 Jun 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVJqxOEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522731B960
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325011; cv=none; b=smqaY7ueRUjvcipwY6HlNhv+5iQiWecbkhhTLe7XelbSglM14BH66f8AJtXqw0qRi51psR96NOOintj7Cgxat/fJ6YKqwas8jux7FKAlr/cXkWbsagF2jV2kOPDxYw4TisJpeVjfFeO38vah7TAeaCFU+RNXqcBEbPTz6WwBqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325011; c=relaxed/simple;
	bh=6aRpxA+Jb6znEDrKK5aOoOK40vlcUNMBHzo1epLI9bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGvwdbqpZ9QHJApW5w8+Q+xm0HNoOBNDlDPaCBEtqTU4Fmg8YYFURU+tfemVcnF2tZK38hueNUwQ+DhK061XmLNEEyc3y8f8a42n1jAiKdsWLbhGKvIYkzQldODgquKEkmk63KtTQoUkPM6Pp11Qv2rU2UCChoTelzPYod8DerQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVJqxOEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE5C32781;
	Tue, 25 Jun 2024 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719325010;
	bh=6aRpxA+Jb6znEDrKK5aOoOK40vlcUNMBHzo1epLI9bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVJqxOEtp4HKNvaKdNM6AFozDmYHb7rQTtUrGIDGuXG/K0if5Z6uKs/lqKWOJH07d
	 VeKIC88+362jaxOL3eOrYZnuNIxcV9+2x6LLDftsqaKMq5FXTYkNQ82cYOr1KPGhf2
	 iqhciBX5ZReeZO5PtvpaF0iccLpBk5I9gpy7pZSCmwE3FJKecrCa2+9EVBIvIxVwIx
	 LcPXr6iUBwKm6FgW+4mvHL9vfTbEVhG/u3uWYxYCzfqK0W+mT2yxHUUBH+PhkyiDrW
	 ELMeeqL/At7BXIG13DCmgKxVN376QcVjolGOFw0OTfB4hDTQveqL9nzfr3Z9ul4Rsj
	 dr/blT5P3eDyA==
Date: Tue, 25 Jun 2024 16:16:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/4] fs: add a helper to show all the options for a mount
Message-ID: <20240625-wallung-rekultivieren-71c4a6c2072f@brauner>
References: <cover.1719257716.git.josef@toxicpanda.com>
 <ba65606c5f233c6d937dfa690325e95712a69a95.1719257716.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba65606c5f233c6d937dfa690325e95712a69a95.1719257716.git.josef@toxicpanda.com>

On Mon, Jun 24, 2024 at 03:40:51PM GMT, Josef Bacik wrote:
> In order to add the ability to export the mount options via statmount()
> we need a helper to combine all the various mount option things we do
> for /proc/mounts and /proc/$PID/mountinfo.  The helper for /proc/mounts
> can use this helper, however mountinfo is slightly (and infuriatingly)
> different, so it can only be used in one place.  This helper will be
> used in a followup patch to export mount options via statmount().
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/internal.h       |  5 +++++
>  fs/proc_namespace.c | 25 ++++++++++++++++++-------
>  2 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 84f371193f74..dc40c9d4173f 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -321,3 +321,8 @@ struct stashed_operations {
>  int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
>  		      struct path *path);
>  void stashed_dentry_prune(struct dentry *dentry);
> +
> +/*
> + * fs/proc_namespace.c
> + */
> +int show_mount_opts(struct seq_file *seq, struct vfsmount *mnt);
> diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> index e133b507ddf3..19bffd9d80dc 100644
> --- a/fs/proc_namespace.c
> +++ b/fs/proc_namespace.c
> @@ -84,6 +84,22 @@ static void show_vfsmnt_opts(struct seq_file *m, struct vfsmount *mnt)
>  		seq_puts(m, ",idmapped");
>  }
>  
> +int show_mount_opts(struct seq_file *seq, struct vfsmount *mnt)
> +{
> +	struct dentry *dentry = mnt->mnt_root;
> +	struct super_block *sb = dentry->d_sb;
> +	int ret;
> +
> +	seq_puts(seq, __mnt_is_readonly(mnt) ? "ro" : "rw");
> +	ret = show_sb_opts(seq, sb);
> +	if (ret)
> +		return ret;
> +	show_vfsmnt_opts(seq, mnt);
> +	if (sb->s_op->show_options)
> +		ret = sb->s_op->show_options(seq, dentry);
> +	return ret;
> +}
> +
>  static inline void mangle(struct seq_file *m, const char *s)
>  {
>  	seq_escape(m, s, " \t\n\\#");
> @@ -120,13 +136,8 @@ static int show_vfsmnt(struct seq_file *m, struct vfsmount *mnt)
>  		goto out;
>  	seq_putc(m, ' ');
>  	show_type(m, sb);
> -	seq_puts(m, __mnt_is_readonly(mnt) ? " ro" : " rw");
> -	err = show_sb_opts(m, sb);
> -	if (err)
> -		goto out;
> -	show_vfsmnt_opts(m, mnt);
> -	if (sb->s_op->show_options)
> -		err = sb->s_op->show_options(m, mnt_path.dentry);
> +	seq_putc(m, ' ');
> +	err = show_mount_opts(m, mnt);
>  	seq_puts(m, " 0 0\n");
>  out:
>  	return err;
> -- 
> 2.43.0
> 

So Karel just made me aware of this. You're using the old /proc/mounts
format here and you're mixing generic sb options, mount options, and fs
specific mount options.

For example, the mount options you're currently passing contain "ro" and
"rw". But these can be either per-mount setting or superblock settings
and that isn't distinguiable based on "ro" and "rw". That information is
also already contained and differentiated in statmount->sb_flags vs
statmount->mnt_attr.

Neither should or does show_vfsmnt_opts() need to be called as all that
information is present in statmount->mnt_attr.

Please only call ->show_options().

