Return-Path: <linux-fsdevel+bounces-45938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A0A7F8D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44ADF424729
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C38B264A7A;
	Tue,  8 Apr 2025 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS49g1i0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72C263F29
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102511; cv=none; b=locrbhShQaXGBDl8Re9ZwqrUIt3UK9hUKu8/UXcKEG51FC35mJvf3GH66aJRnoBT9bO07OtyJ5zNINXB7lGOEQHCVcixEijs/N/Eg+oNZFSJWLPobEPyNy1LlBCLa1KrsLX6tDDpwAsxMbejhrNNPFG9DMKfl8+idI5LGT7Sqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102511; c=relaxed/simple;
	bh=pXC9rrSFVnww5u6olMitl2a68CpctSHxREyaSN5KVm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfvXd/vB/5fnx6jng5TR/qfYw7zBMmGhqJ2jcz0IHTo5btk2KVtUxbFrjqr+MVDuphoJpkyCSv/sQ3b0TQTQGv+ShWIvlu/7JSOUnZwnkJpMO0B/6dHGWkejghMPINAHp+hME/LmMuiRbg3skSkLBLOLjDSlEgSGxqsgeGiO4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS49g1i0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67786C4CEE8;
	Tue,  8 Apr 2025 08:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744102511;
	bh=pXC9rrSFVnww5u6olMitl2a68CpctSHxREyaSN5KVm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SS49g1i07TI1VbRu5P4hwHD+Zvdc58wYNWXjnQG//h0Db4i7oyyCb5W7JvnnL1u6P
	 d15sR+I9p37HEwNvAk9Ib491KcJScmK8lpTyqZzvNXWLAedn/+RD9hUJAxsTDvoUc2
	 rohOOVscI94hoA3QgGjT98/IGDw0LjF+fHMGJFIvjEVn8xQVicd89nTUJBabHQyvfV
	 dhvoBHuVlOx/AhSEvuuwysyIhRELF1UeL4vUGvJaLaS5mYzqpowMu0pOkw5BPYmjiR
	 FmbL9vS4zcv3IiiAcA/lb9DuITP7BBDH8a7h3O6U3R2+B46NHCB+KXsiRacp1UHttE
	 5QJRhMijXBplA==
Date: Tue, 8 Apr 2025 10:55:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, mkoutny@suse.cz
Subject: Re: d_path() results in presence of detached mounts
Message-ID: <20250408-ungebeten-auskommen-5a2aaab8e23d@brauner>
References: <rxytpo37ld46vclkts457zvwi6qkgwzlh3loavn3lddqxe2cvk@k7lifplt7ay6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rxytpo37ld46vclkts457zvwi6qkgwzlh3loavn3lddqxe2cvk@k7lifplt7ay6>

On Mon, Apr 07, 2025 at 06:00:07PM +0200, Jan Kara wrote:
> Hello!
> 
> Recently I've got a question from a user about the following:
> 
> # unshare --mount swapon /dev/sda3
> # cat /proc/swaps
> Filename                                Type            Size            Used            Priority
> /sda3                                   partition       2098152         0               -2
> 
> Now everything works as expected here AFAICS. When namespace gets created
> /dev mount is cloned into it. When swapon exits, the namespace is
> destroyed and /dev mount clone is detached (no parent, namespace NULL).
> Hence when d_path() crawls the path it stops at the mountpoint root and
> exits. There's not much we can do about this but when discussing the
> situation internally, Michal proposed that d_path() could append something
> like "(detached)" to the path string - similarly to "(deleted)". That could
> somewhat reduce the confusion about such paths? What do people think about
> this?

You can get into this situation in plenty of other ways. For example by
using detached mount via open_tree(OPEN_TREE_CLONE) as layers in
overlayfs. Or simply:

        int fd;
        char dpath[PATH_MAX];

        fd = open_tree(-EBADF, "/var/lib/fwupd", OPEN_TREE_CLONE);
        dup2(fd, 500);
        close(fd);
        readlink("/proc/self/fd/500", dpath, sizeof(dpath));
        printf("dpath = %s\n", dpath);

Showing "(detached)" will be ambiguous just like "(deleted)" is. If that
doesn't matter and it's clearly documented then it's probably fine. But
note that this will also affect /proc/<pid>/fd/ as can be seen from the
above example.

int main(int argc, char *argv[])
{
        int fd;
        char dpath[PATH_MAX];
        char *dirs[] = { "/ONE", "TWO", "THREE", "FOUR", NULL };

        for (char **dir = dirs; *dir; dir++) {
                mkdir(*dir, 0777);
                chdir(*dir);
        }

        chdir("/");
        fd = open_tree(-EBADF, "/ONE/TWO/THREE/FOUR", OPEN_TREE_CLONE);
        if (fd < 0) {
                perror("open_tree");
                _exit(1);
        }

        rmdir("/ONE/TWO/THREE/FOUR");

        if (dup2(fd, 500) < 0) {
                perror("dup2");
                _exit(1);
        }
        close(fd);

        readlink("/proc/self/fd/500", dpath, sizeof(dpath));
        if (strcmp("/ (detached) (deleted)", dpath) != 0) {
                printf("wrong dpath = %s\n", dpath);
                _exit(1);
        }
        printf("dpath = %s\n", dpath);
        _exit(0);
}

user1@localhost:~/data/scripts$ sudo ./open_tree_detached
dpath = / (detached) (deleted)

Seems good to me.

Should be as simple as:

diff --git a/fs/d_path.c b/fs/d_path.c
index 5f4da5c8d5db..58874a107634 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -246,6 +246,12 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
        } while (read_seqcount_retry(&fs->seq, seq));
 }

+static inline bool is_detached(struct mount *mnt)
+{
+       struct mnt_namespace *mnt_ns = READ_ONCE(mnt->mnt_ns);
+       return unlikely(!mnt_ns || is_anon_ns(mnt_ns));
+}
+
 /**
  * d_path - return the path of a dentry
  * @path: path to report
@@ -284,7 +290,11 @@ char *d_path(const struct path *path, char *buf, int buflen)

        rcu_read_lock();
        get_fs_root_rcu(current->fs, &root);
-       if (unlikely(d_unlinked(path->dentry)))
+       if (unlikely(is_detached(real_mount(path->mnt))) && d_unlinked(path->dentry))
+               prepend(&b, " (detached) (deleted)", 22);
+       else if (unlikely(is_detached(real_mount(path->mnt))))
+               prepend(&b, " (detached)", 11);
+       else if (unlikely(d_unlinked(path->dentry)))
                prepend(&b, " (deleted)", 11);
        else
                prepend_char(&b, 0);

This is racy. Iow, after the first check it's still possible that it's
both detached and deleted. But I don't think that matters. (deleted)
must stay at the end because there's userspace out there that expects
(deleted) to be at the end.


