Return-Path: <linux-fsdevel+bounces-78845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UUpUAjdPpGkPdQUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 15:37:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5771D03B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8B7A300FB71
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F3C31716F;
	Sun,  1 Mar 2026 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV0yiL5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB221F5847
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Mar 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772375856; cv=pass; b=llrfHIxDCq7RbUuXI4ibDOyhYjzKVa1sZXu9X0rc+HMYVeSMEwIg9WSXcrnCyWj/86zcSKT31xIMRDkU1sDTeWGm7a24cRWJsAokzXmy545mG5V8KNE3Xlc4tywjukDDnFEi23u7T9mEV82G5SGon4vM0D0lEa/nl4A8la9T7R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772375856; c=relaxed/simple;
	bh=625gZNnRxZIFUziWnhyJIyHHkF1YBFCE+gLuVfaoUbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLlLXDK9nHy1NwUh1mdc80Ck/a/9h/V/Y0X8LMrzls9WBCB5gT+L58CGuwy5gq7hdH/NUp6d2+y1B4lkBR+e9iYxhvsjeAZ6rlDqU4Xcn4Oi0k26C8cVngbPEAxcdN+SR0CLyCzdhz/eQTrfiwhFpOy8GEaOInSmNw8CtOd5Gtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV0yiL5r; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8fa449e618so512872966b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 06:37:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772375854; cv=none;
        d=google.com; s=arc-20240605;
        b=I+jcEU9a4I2hvobflD3n1QIN7Ne8JxENex5jtK1FPLJmB4sDfrl2bw25xf3Nnj6VaD
         WTRMAmyng41yxJiB5WP6nJiYDMcEjWM7ehcR03lgZipNTXAb1IYFjasBTEmJsR/wKLxY
         YZL5QJcMiWWpWhc6p+JFo13c7yiSvaE+/wWIaDcAu0ZXbHCOeASgpb/Po+jKLvo7HozU
         Zb1++bbUf6SRHtIIk4ERfqadhBo398PfkboeFRD3DgtlXqPfD0e/J2W+LoQb7Qy5JrOZ
         10pahC8uZ0bonAc5PlSreZL9/QHCUVhA+qlJC0xS3lQ1NdE6pun0nwuhdM1xwQ6UU9ee
         pzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ygkpdtgYt43wLbKzCQcb7cO94CFKVbX0lUDx+zyuuvA=;
        fh=jTfmdAIzt/zAtc0XBT/w+bOGj8t3uUQnaIDlpeNTr1Q=;
        b=fhwMf011Dh3F8Ul7lP+8aliYFFU/ZsbRS/Sifv26x3pmusvNTa4O7qBIgCOAPDBYVL
         yXT6HbSMKtUW1JtRJxYk6gCfEZkY9dwI90vXt0fQEPkOp1M2j+D7jE22qZaZq47vKVh4
         XphMpKKPjvalg2cRWL7XEGXfWq8N2SQhu5p0vvR+h2ohu9NOAIqWBGGJ7FVOpp7/5BGz
         HgXRdTntv88uz8nsBobaNHME/f3X5HDGo1qX9SygbCFELW9QF3D+zL9kw0wwT6wW2DJj
         t4iHuzlP9iVF5l670jlA7bhyS5HH4xm7wlsVjcCKoUdTF768C4LMJqPftSrtjSa6qdOJ
         +5Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772375854; x=1772980654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygkpdtgYt43wLbKzCQcb7cO94CFKVbX0lUDx+zyuuvA=;
        b=WV0yiL5r/66xXtglTQp7GDHZ8zbwFvXRSrpnwdQ1iE1asnO0Lv874s0Emh3OL3WUOt
         TGqbWPEWCtvaX2IQcRf+PrZ5C7Nt0veyvy6iO8kbKi0svgzrV2nsWNAUpZs2eiOp/Z+z
         D+Jhwi1yy10AYHNPTdgA0CPfSYDRsSy3r1FXP603xyVXuWvJO68YCNZCLewa7QMOwreX
         hVgberXZhXScHw/6UW6P7qadXLeJ/rsOMLfYDob4HDeXcll+zn57G4EyqNYMYgwy5V45
         oNF2VH1laL5IvRCQR03z/JVAsimAV8Hcs1fVr3M7YfIwC+XfHFPY6IIat6wkHxe7G+f6
         FL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772375854; x=1772980654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygkpdtgYt43wLbKzCQcb7cO94CFKVbX0lUDx+zyuuvA=;
        b=VCk5p000JuyVtHKKB6NZ3wa2Rr+kKsYG9L7BX52qfklb5bi6OLvoX0rPBOmw59/99m
         ZKMZObDQVKk2K3YuQZKs5Kxwbj5cAi+u2ZfF5vjBqPnWzryU97Ri+jqFSioEj/UReiGD
         D8Tlg3DP/a/eCo+9tIrP7eYodOCd4cjRrq4ptostnTUAM1z+xqpk+/IKOtNZRHzQFSvo
         boYGnmRZypJWY9RcMeo9vd5r3lBe3E82JBYu9HDAAiugAmwN/jQLkxQjBQn9+pTuTUzx
         bEkOmWdLg7aXLHm2gAUwlp3z/0Hxn1kyX+99wHiR38BXGqtJXI0bbwOPfR0JWwOGNN8p
         yOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOpe+UnLeDNCcvrFIFbnBO59pZ0iiuuEqv+R6gdEPxO+2roBLwsfzRuLN+0Voo1OgS9cGOlcDOCREwTEFe@vger.kernel.org
X-Gm-Message-State: AOJu0YyBDcJK0tLdAcG+KXDryyALGpnHKB3rcSMJ5okCfl96Odu4KLk6
	Vla+WBRPF7fPLth3o2RjsOGL+nTjQ1ufZ0eHN+tF1LDpjfNkQB5UTAvVKVNW8rk40dBr7MbJ9+K
	rdSxL0CNgjeGmig7xaXkwAI+4SRym3ZIGEZ+xsHg=
X-Gm-Gg: ATEYQzzp0R6kIW0N6zdugDP17haqMLTe0YwiY4WaT/1UGmVGfj4wgBKeaf7yF/1FqVU
	TrUFlacUoyVgqBaHjPfOvWAHAt99m1tsHqazxcTcirSAjIkY63xb8mCLvkA+N0ecD3ZP9GEoZyg
	j7pnFDMvbwWQazOXyfW70n0ok9lL47nXUWzUxZrhVZ8EA1HwM5DBVK4TgYuRpGefnQSRLiB6GTS
	Ag/Bx0h1Vu3MWzBpIZU6vRJLjsID+jjkUdkHkeqjrXTS6MZ8dGaSoxAHJMZ7iViFPVNF5Qwnuja
	zD3YB66tJF8HJqdk+MG6ONIJnd+FHKB08nTMgrarxQ==
X-Received: by 2002:a17:907:72d3:b0:b8e:d260:cb32 with SMTP id
 a640c23a62f3a-b937636251amr594760166b.1.1772375853311; Sun, 01 Mar 2026
 06:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224163908.44060-1-cel@kernel.org> <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner> <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org> <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
In-Reply-To: <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 1 Mar 2026 15:37:22 +0100
X-Gm-Features: AaiRm512SKV0wxOihBEzE38zQxTfytsYOSFftGIB6yHszI6KOOrNArgilOtkWq0
Message-ID: <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: Chuck Lever <cel@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>, 
	NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78845-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,suse.com,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6B5771D03B4
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:10=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On 2/26/26 8:32 AM, Jan Kara wrote:
> > On Thu 26-02-26 08:27:00, Chuck Lever wrote:
> >> On 2/26/26 5:52 AM, Amir Goldstein wrote:
> >>> On Thu, Feb 26, 2026 at 9:48=E2=80=AFAM Christian Brauner <brauner@ke=
rnel.org> wrote:
> >>>> Another thing: These ad-hoc notifiers are horrific. So I'm pitching
> >>>> another idea and I hope that Jan and Amir can tell me that this is
> >>>> doable...
> >>>>
> >>>> Can we extend fsnotify so that it's possible for a filesystem to
> >>>> register "internal watches" on relevant objects such as mounts and
> >>>> superblocks and get notified and execute blocking stuff if needed.
> >>>>
> >>>
> >>> You mean like nfsd_file_fsnotify_group? ;)
> >>>
> >>>> Then we don't have to add another set of custom notification mechani=
sms
> >>>> but have it available in a single subsystem and uniformely available=
.
> >>>>
> >>>
> >>> I don't see a problem with nfsd registering for FS_UNMOUNT
> >>> event on sb (once we add it).
> >>>
> >>> As a matter of fact, I think that nfsd can already add an inode
> >>> mark on the export root path for FS_UNMOUNT event.
> >>
> >> There isn't much required here aside from getting a synchronous notice
> >> that the final file system unmount is going on. I'm happy to try
> >> whatever mechanism VFS maintainers are most comfortable with.
> >
> > Yeah, then as Amir writes placing a mark with FS_UNMOUNT event on the
> > export root path and handling the event in
> > nfsd_file_fsnotify_handle_event() should do what you need?
>
> Turns out FS_UNMOUNT doesn't do what I need.
>
> 1/3 here has a fatal flaw: the SRCU notifier does not fire until all
> files on the mount are closed. The problem is that NFSD holds files
> open when there is outstanding NFSv4 state. So the SRCU notifier will
> never fire, on umount, to release that state.
>
> FS_UNMOUNT notifiers have the same issue.
>
> They fire from fsnotify_sb_delete() inside generic_shutdown_super(),
> which runs inside deactivate_locked_super(), which runs when s_active
> drops to 0. That requires all mounts to be freed, which requires all
> NFSD files to be closed: the same problem.
>
> For any notification approach to actually do what is needed, it needs to
> fire during do_umount(), before propagate_mount_busy(). Something like:
>
> do_umount(mnt):
>     <- NEW: notify subsystems, allow them to release file refs
>     retval =3D propagate_mount_busy(mnt, 2)   // now passes
>     umount_tree(mnt, ...)
>
> This is what Christian's "internal watches... execute blocking stuff"
> would need to enable. The existing fsnotify plumbing (groups, marks,
> event dispatch) provides the infrastructure, but a new notification hook
> in do_umount() is required =E2=80=94 neither fsnotify_vfsmount_delete() n=
or
> fsnotify_sb_delete() fires early enough.
>
> But a hook in do_umount() fires for every mount namespace teardown, not
> just admin-initiated unmounts. NFSD's callback would need to filter
> (e.g., only act when it's the last mount of a superblock that NFSD is
> exporting).
>
> This is why I originally went with fs_pin. Not saying the series should
> go back to that, but this is the basic requirement: NFSD needs
> notification of a umount request while files are still open on that
> mount, so that it can revoke the NFSv4 state and close those files.
>

I understand the problem with FS_UNMOUNT, but I fail to understand
the desired semantics, specifically the "the last mount of a superblock
that NFSD is exporting".

One option is that nfsd will use a private mount clone for accessing
files as overlayfs does and wait until all the other mounts are gone,
but FWIW that has some user visible implications.

Then we can enable subscribing for FS_MNT_DETACH events on a
super_block.
fanotify UAPI currently only allows subscribing them on mntns,
but allowing internal users to subscribe on all the unmounts of a sb
should be as simple as below (famous last word).

Thanks,
Amir.


diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 9995de1710e59..0abe16db3636c 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -695,6 +695,7 @@ void fsnotify_mnt(__u32 mask, struct mnt_namespace
*ns, struct vfsmount *mnt)
 {
        struct fsnotify_mnt data =3D {
                .ns =3D ns,
+               .sb =3D mnt->mnt_sb,
                .mnt_id =3D real_mount(mnt)->mnt_id_unique,
        };

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_back=
end.h
index 95985400d3d8e..c21fae333f0dc 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -332,6 +332,7 @@ static inline const struct path
*file_range_path(const struct file_range *range)

 struct fsnotify_mnt {
        const struct mnt_namespace *ns;
+       struct super_block *sb;
        u64 mnt_id;
 };

@@ -395,6 +396,8 @@ static inline struct super_block
*fsnotify_data_sb(const void *data,
                return file_range_path(data)->dentry->d_sb;
        case FSNOTIFY_EVENT_ERROR:
                return ((struct fs_error_report *) data)->sb;
+       case FSNOTIFY_EVENT_MNT:
+               return ((struct fsnotify_mnt *)data)->sb;
        default:
                return NULL;
        }

