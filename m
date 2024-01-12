Return-Path: <linux-fsdevel+bounces-7871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D682C04C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 14:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958FC1C21BB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A376BB4B;
	Fri, 12 Jan 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXnY3A6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630366A015
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbd6e37a9bso5373499b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 05:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705064439; x=1705669239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T328KLghnBFgoHBtORJYwvRyk5ewe7jI6p820n6qi3Q=;
        b=XXnY3A6xkkfbYJ1YU7SWiTCDgapfiUY+X8dcgar1xHCjN9YGbpYwi+UpBhVGf1M9+m
         2bWtf1jnpYPeKe4nkDghsgWKZ/j7UWlgXMk2BH709MdBoNMQlHOv1+1UAC/pi/GVfnyy
         JhL8ZvYDmfPgkATBCf0siDjpBvSea5Oj1zRnj6Br9Tr0ZuPP+A5nitB4nBmF48kCpqB1
         DI6DVsnEyW/TFEYefFtoNzqt5Y/y8AluOHQO2dvBpRPEvHluhRHYBrWAVbISAXK2DZ6f
         n+fy6nxEqk1N+3q7D1J2cBmxt6d0cedCU+0+0xVUT+67B8BF2efIK6+kaP4Qldc8T7ju
         yAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705064439; x=1705669239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T328KLghnBFgoHBtORJYwvRyk5ewe7jI6p820n6qi3Q=;
        b=p9tH/98NTODKS25rldeSnITC/qeCD6K/NmopE9SpDK/QJNh2+/Y+iPagzdL6+funVW
         eqz90N7D17uy0qYgO1KPQc8UyHTU7QuIeVCctLYY8Ys7y9J7Be2bVCsV87xiJAlWMvAb
         9DXohs5iOXi6Rlr5KK6u1JFWdAXFyJWtkkBwTrwAXt/j/J3PfTZVskPybE3GPvWC3pv+
         PtUehbJ8dYgkh0V/NSRk0G44IRAbVHBtnfNTDv2PFhs0opoCBrR9kDK9A4me1522F3L4
         AyCMi7vxiO7ds9V4PNW7lez0YLSrt/RZ2F80P/Ztr2HLk/9Vpzvm4GwOmuJWuwec3xx0
         E+yg==
X-Gm-Message-State: AOJu0YwqtClWQ3bcArqjYvP8WsqOUD1YBN5baJ8H66obTvhgDuz0oMqI
	hrcObLNMbGThrjjfvjljqdUSc0B45DCyBqfs4P4=
X-Google-Smtp-Source: AGHT+IGR7a/s31Un7aMfQp7lsaMSCVHSGRwHDjRdu89Tr2ZgjCijAxKegsglbTtaQ546g5l8xBcF3qgOSFFsSpG5W/Q=
X-Received: by 2002:a05:6808:1b2a:b0:3bd:5627:14b9 with SMTP id
 bx42-20020a0568081b2a00b003bd562714b9mr1115566oib.50.1705064439166; Fri, 12
 Jan 2024 05:00:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111152233.352912-1-amir73il@gmail.com> <20240112110936.ibz4s42x75mjzhlv@quack3>
In-Reply-To: <20240112110936.ibz4s42x75mjzhlv@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Jan 2024 15:00:27 +0200
Message-ID: <CAOQ4uxgAGpBTeEyqJTSGn5OvqaxsVP3yXR6zuS-G9QWnTjoV9w@mail.gmail.com>
Subject: Re: [RFC][PATCH v2] fsnotify: optimize the case of no content event watchers
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000037cf98060ebf406e"

--00000000000037cf98060ebf406e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 1:09=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 11-01-24 17:22:33, Amir Goldstein wrote:
> > Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any ty=
pe")
> > optimized the case where there are no fsnotify watchers on any of the
> > filesystem's objects.
> >
> > It is quite common for a system to have a single local filesystem and
> > it is quite common for the system to have some inotify watches on some
> > config files or directories, so the optimization of no marks at all is
> > often not in effect.
> >
> > Content event (i.e. access,modify) watchers on sb/mount more rare, so
> > optimizing the case of no sb/mount marks with content events can improv=
e
> > performance for more systems, especially for performance sensitive io
> > workloads.
> >
> > Set a per-sb flag SB_I_CONTENT_WATCHED if sb/mount marks with content
> > events in their mask exist and use that flag to optimize out the call t=
o
> > __fsnotify_parent() and fsnotify() in fsnotify access/modify hooks.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> ...
>
> > -static inline int fsnotify_file(struct file *file, __u32 mask)
> > +static inline int fsnotify_path(const struct path *path, __u32 mask)
> >  {
> > -     const struct path *path;
> > +     struct dentry *dentry =3D path->dentry;
> >
> > -     if (file->f_mode & FMODE_NONOTIFY)
> > +     if (!fsnotify_sb_has_watchers(dentry->d_sb))
> >               return 0;
> >
> > -     path =3D &file->f_path;
> > +     /* Optimize the likely case of sb/mount/parent not watching conte=
nt */
> > +     if (mask & FSNOTIFY_CONTENT_EVENTS &&
> > +         likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)) &=
&
> > +         likely(!(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED))) {
> > +             /*
> > +              * XXX: if SB_I_CONTENT_WATCHED is not set, checking for =
content
> > +              * events in s_fsnotify_mask is redundant, but it will be=
 needed
> > +              * if we use the flag FS_MNT_CONTENT_WATCHED to indicate =
the
> > +              * existence of only mount content event watchers.
> > +              */
> > +             __u32 marks_mask =3D d_inode(dentry)->i_fsnotify_mask |
> > +                                dentry->d_sb->s_fsnotify_mask;
> > +
> > +             if (!(mask & marks_mask))
> > +                     return 0;
> > +     }
>
> So I'm probably missing something but how is all this patch different fro=
m:
>
>         if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))) =
{
>                 __u32 marks_mask =3D d_inode(dentry)->i_fsnotify_mask |
>                         path->mnt->mnt_fsnotify_mask |

It's actually:

                          real_mount(path->mnt)->mnt_fsnotify_mask

and this requires including "internal/mount.h" in all the call sites.

>                         dentry->d_sb->s_fsnotify_mask;
>                 if (!(mask & marks_mask))
>                         return 0;
>         }
>
> I mean (mask & FSNOTIFY_CONTENT_EVENTS) is true for the frequent events
> (read & write) we care about. In Jens' case
>
>         !(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
>         !(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED)
>
> is true as otherwise we'd go right to fsnotify_parent() and so Jens
> wouldn't see the performance benefit. But then with your patch you fetch
> i_fsnotify_mask and s_fsnotify_mask anyway for the test so the only
> difference to what I suggest above is the path->mnt->mnt_fsnotify_mask
> fetch but that is equivalent to sb->s_iflags (or wherever we store that
> bit) fetch?
>
> So that would confirm that the parent handling costs in fsnotify_parent()
> is what's really making the difference and just avoiding that by checking
> masks early should be enough?

Can't the benefit be also related to saving a function call?

Only one way to find out...

Jens,

Can you please test attached v3 with a non-inlined fsnotify_path() helper?

Thanks,
Amir.

--00000000000037cf98060ebf406e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v3-0001-fsnotify-optimize-the-case-of-no-content-event-wa.patch"
Content-Disposition: attachment; 
	filename="v3-0001-fsnotify-optimize-the-case-of-no-content-event-wa.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lranc09e0>
X-Attachment-Id: f_lranc09e0

RnJvbSA3ZmEyMTk1MTY0N2FlMjQyOTZjZDA2MDJmMTI5MWQwMGE4ZmE4NGQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDkgRGVjIDIwMjIgMTE6NTA6MjYgKzAyMDAKU3ViamVjdDogW1BBVENIIHYzXSBm
c25vdGlmeTogb3B0aW1pemUgdGhlIGNhc2Ugb2Ygbm8gY29udGVudCBldmVudCB3YXRjaGVycwoK
Q29tbWl0IGU0M2RlN2YwODYyYiAoImZzbm90aWZ5OiBvcHRpbWl6ZSB0aGUgY2FzZSBvZiBubyBt
YXJrcyBvZiBhbnkgdHlwZSIpCm9wdGltaXplZCB0aGUgY2FzZSB3aGVyZSB0aGVyZSBhcmUgbm8g
ZnNub3RpZnkgd2F0Y2hlcnMgb24gYW55IG9mIHRoZQpmaWxlc3lzdGVtJ3Mgb2JqZWN0cy4KCkl0
IGlzIHF1aXRlIGNvbW1vbiBmb3IgYSBzeXN0ZW0gdG8gaGF2ZSBhIHNpbmdsZSBsb2NhbCBmaWxl
c3lzdGVtIGFuZAppdCBpcyBxdWl0ZSBjb21tb24gZm9yIHRoZSBzeXN0ZW0gdG8gaGF2ZSBzb21l
IGlub3RpZnkgd2F0Y2hlcyBvbiBzb21lCmNvbmZpZyBmaWxlcyBvciBkaXJlY3Rvcmllcywgc28g
dGhlIG9wdGltaXphdGlvbiBvZiBubyBtYXJrcyBhdCBhbGwgaXMKb2Z0ZW4gbm90IGluIGVmZmVj
dC4KCkNvbnRlbnQgZXZlbnQgKGkuZS4gYWNjZXNzLG1vZGlmeSkgd2F0Y2hlcnMgb24gc2IvbW91
bnQgbW9yZSByYXJlLCBzbwpvcHRpbWl6aW5nIHRoZSBjYXNlIG9mIG5vIHNiL21vdW50IG1hcmtz
IHdpdGggY29udGVudCBldmVudHMgY2FuIGltcHJvdmUKcGVyZm9ybWFuY2UgZm9yIG1vcmUgc3lz
dGVtcywgZXNwZWNpYWxseSBmb3IgcGVyZm9ybWFuY2Ugc2Vuc2l0aXZlIGlvCndvcmtsb2Fkcy4K
ClVubGVzcyBhIHBhcmVudCBpbm9kZSBpcyB3YXRjaGluZywgY2hlY2sgZm9yIGNvbnRlbnQgZXZl
bnRzIGluIG1hc2tzIG9mCnNiL21vdW50L2lub2RlIG1hc2tzIGVhcmx5IHRvIG9wdGltaXplIG91
dCB0aGUgY29kZSBpbiBfX2Zzbm90aWZ5X3BhcmVudCgpCmFuZCBmc25vdGlmeSgpIGZvciBmc25v
dGlmeSBhY2Nlc3MvbW9kaWZ5IGhvb2tzLgoKU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4g
PGFtaXI3M2lsQGdtYWlsLmNvbT4KLS0tCiBmcy9ub3RpZnkvZnNub3RpZnkuYyAgICAgICAgICAg
ICB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrCiBmcy9ub3RpZnkvbWFyay5jICAgICAg
ICAgICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKystCiBpbmNsdWRlL2xpbnV4
L2ZzLmggICAgICAgICAgICAgICB8ICAxICsKIGluY2x1ZGUvbGludXgvZnNub3RpZnkuaCAgICAg
ICAgIHwgMjEgKysrKysrKysrKysrLS0tLS0tLS0tCiBpbmNsdWRlL2xpbnV4L2Zzbm90aWZ5X2Jh
Y2tlbmQuaCB8IDEzICsrKysrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9u
cygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbm90aWZ5L2Zzbm90aWZ5LmMg
Yi9mcy9ub3RpZnkvZnNub3RpZnkuYwppbmRleCA3OTc0ZTkxZmZlMTMuLmI5NjI1MWNkZDE2NSAx
MDA2NDQKLS0tIGEvZnMvbm90aWZ5L2Zzbm90aWZ5LmMKKysrIGIvZnMvbm90aWZ5L2Zzbm90aWZ5
LmMKQEAgLTIzNyw2ICsyMzcsMzIgQEAgaW50IF9fZnNub3RpZnlfcGFyZW50KHN0cnVjdCBkZW50
cnkgKmRlbnRyeSwgX191MzIgbWFzaywgY29uc3Qgdm9pZCAqZGF0YSwKIH0KIEVYUE9SVF9TWU1C
T0xfR1BMKF9fZnNub3RpZnlfcGFyZW50KTsKIAorLyogTm90aWZ5IHNiL21vdW50L2lub2RlL3Bh
cmVudCB3YXRjaGVycyBvZiB0aGlzIHBhdGggKi8KK2ludCBmc25vdGlmeV9wYXRoKGNvbnN0IHN0
cnVjdCBwYXRoICpwYXRoLCBfX3UzMiBtYXNrKQoreworCXN0cnVjdCBkZW50cnkgKmRlbnRyeSA9
IHBhdGgtPmRlbnRyeTsKKworCWlmICghZnNub3RpZnlfc2JfaGFzX3dhdGNoZXJzKGRlbnRyeS0+
ZF9zYikpCisJCXJldHVybiAwOworCisJLyogT3B0aW1pemUgdGhlIGxpa2VseSBjYXNlIG9mIHNi
L21vdW50L2lub2RlIG5vdCB3YXRjaGluZyBjb250ZW50ICovCisJaWYgKG1hc2sgJiBGU05PVElG
WV9DT05URU5UX0VWRU5UUyAmJgorCSAgICBsaWtlbHkoIShkZW50cnktPmRfZmxhZ3MgJiBEQ0FD
SEVfRlNOT1RJRllfUEFSRU5UX1dBVENIRUQpKSkgeworCQlfX3UzMiBtYXJrc19tYXNrID0gZF9p
bm9kZShkZW50cnkpLT5pX2Zzbm90aWZ5X21hc2sgfAorCQkJCSAgIHJlYWxfbW91bnQocGF0aC0+
bW50KS0+bW50X2Zzbm90aWZ5X21hc2sgfAorCQkJCSAgIGRlbnRyeS0+ZF9zYi0+c19mc25vdGlm
eV9tYXNrOworCisJCWlmICghKG1hc2sgJiBtYXJrc19tYXNrKSkKKwkJCXJldHVybiAwOworCX0K
KworCS8qCisJICogZnNub3RpZnlfcGFyZW50KCkgY2hlY2tzIHRoZSBldmVudCBtYXNrcyBvZiBz
Yi9tb3VudC9pbm9kZS9wYXJlbnQuCisJICovCisJcmV0dXJuIGZzbm90aWZ5X3BhcmVudChwYXRo
LT5kZW50cnksIG1hc2ssIHBhdGgsIEZTTk9USUZZX0VWRU5UX1BBVEgpOworfQorRVhQT1JUX1NZ
TUJPTF9HUEwoZnNub3RpZnlfcGF0aCk7CisKIHN0YXRpYyBpbnQgZnNub3RpZnlfaGFuZGxlX2lu
b2RlX2V2ZW50KHN0cnVjdCBmc25vdGlmeV9ncm91cCAqZ3JvdXAsCiAJCQkJICAgICAgIHN0cnVj
dCBmc25vdGlmeV9tYXJrICppbm9kZV9tYXJrLAogCQkJCSAgICAgICB1MzIgbWFzaywgY29uc3Qg
dm9pZCAqZGF0YSwgaW50IGRhdGFfdHlwZSwKZGlmZiAtLWdpdCBhL2ZzL25vdGlmeS9tYXJrLmMg
Yi9mcy9ub3RpZnkvbWFyay5jCmluZGV4IGQ2OTQ0ZmY4NmZmYS4uZDBlMjA4OTEzODgxIDEwMDY0
NAotLS0gYS9mcy9ub3RpZnkvbWFyay5jCisrKyBiL2ZzL25vdGlmeS9tYXJrLmMKQEAgLTE1Myw5
ICsxNTMsMzAgQEAgc3RhdGljIHN0cnVjdCBpbm9kZSAqZnNub3RpZnlfdXBkYXRlX2lyZWYoc3Ry
dWN0IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yICpjb25uLAogCXJldHVybiBpbm9kZTsKIH0KIAor
LyoKKyAqIFRvIGF2b2lkIHRoZSBwZXJmb3JtYW5jZSBwZW5hbHR5IG9mIHJhcmUgY2FzZSBvZiBz
Yi9tb3VudCBjb250ZW50IGV2ZW50CisgKiB3YXRjaGVycyBpbiB0aGUgaG90IGlvIHBhdGgsIHRh
aW50IHNiIGlmIHN1Y2ggd2F0Y2hlcnMgYXJlIGFkZGVkLgorICovCitzdGF0aWMgdm9pZCBmc25v
dGlmeV91cGRhdGVfc2Jfd2F0Y2hlcnMoc3RydWN0IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yICpj
b25uLAorCQkJCQl1MzIgb2xkX21hc2ssIHUzMiBuZXdfbWFzaykKK3sKKwlzdHJ1Y3Qgc3VwZXJf
YmxvY2sgKnNiID0gZnNub3RpZnlfY29ubmVjdG9yX3NiKGNvbm4pOworCXUzMiBuZXdfd2F0Y2hl
cnMgPSBuZXdfbWFzayAmIH5vbGRfbWFzayAmIEZTTk9USUZZX0NPTlRFTlRfRVZFTlRTOworCisJ
aWYgKGNvbm4tPnR5cGUgPT0gRlNOT1RJRllfT0JKX1RZUEVfSU5PREUgfHwgIXNiIHx8ICFuZXdf
d2F0Y2hlcnMpCisJCXJldHVybjsKKworCS8qCisJICogVE9ETzogV2UgbmVlZCB0byB0YWtlIHNi
IGNvbm4tPmxvY2sgdG8gc2V0IEZTX01OVF9DT05URU5UX1dBVENIRUQKKwkgKiBpbiBzYi0+c19m
c25vdGlmeV9tYXNrLCBidXQgaWYgdGhpcyBpcyBhIHJlY2FsYyBvZiBtb3VudCBtYXJrIG1hc2ss
CisJICogaXQgaXMgbm90IHN1cmUgdGhhdCB3ZSBoYXZlIGFuIHNiIGNvbm5lY3RvciBhdHRhY2hl
ZCB5ZXQuCisJICovCisJc2ItPnNfaWZsYWdzIHw9IFNCX0lfQ09OVEVOVF9XQVRDSEVEOworfQor
CiBzdGF0aWMgdm9pZCAqX19mc25vdGlmeV9yZWNhbGNfbWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFy
a19jb25uZWN0b3IgKmNvbm4pCiB7Ci0JdTMyIG5ld19tYXNrID0gMDsKKwl1MzIgb2xkX21hc2ss
IG5ld19tYXNrID0gMDsKIAlib29sIHdhbnRfaXJlZiA9IGZhbHNlOwogCXN0cnVjdCBmc25vdGlm
eV9tYXJrICptYXJrOwogCkBAIC0xNjMsNiArMTg0LDcgQEAgc3RhdGljIHZvaWQgKl9fZnNub3Rp
ZnlfcmVjYWxjX21hc2soc3RydWN0IGZzbm90aWZ5X21hcmtfY29ubmVjdG9yICpjb25uKQogCS8q
IFdlIGNhbiBnZXQgZGV0YWNoZWQgY29ubmVjdG9yIGhlcmUgd2hlbiBpbm9kZSBpcyBnZXR0aW5n
IHVubGlua2VkLiAqLwogCWlmICghZnNub3RpZnlfdmFsaWRfb2JqX3R5cGUoY29ubi0+dHlwZSkp
CiAJCXJldHVybiBOVUxMOworCW9sZF9tYXNrID0gZnNub3RpZnlfY29ubl9tYXNrKGNvbm4pOwog
CWhsaXN0X2Zvcl9lYWNoX2VudHJ5KG1hcmssICZjb25uLT5saXN0LCBvYmpfbGlzdCkgewogCQlp
ZiAoIShtYXJrLT5mbGFncyAmIEZTTk9USUZZX01BUktfRkxBR19BVFRBQ0hFRCkpCiAJCQljb250
aW51ZTsKQEAgLTE3Myw2ICsxOTUsOCBAQCBzdGF0aWMgdm9pZCAqX19mc25vdGlmeV9yZWNhbGNf
bWFzayhzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0b3IgKmNvbm4pCiAJfQogCSpmc25vdGlm
eV9jb25uX21hc2tfcChjb25uKSA9IG5ld19tYXNrOwogCisJZnNub3RpZnlfdXBkYXRlX3NiX3dh
dGNoZXJzKGNvbm4sIG9sZF9tYXNrLCBuZXdfbWFzayk7CisKIAlyZXR1cm4gZnNub3RpZnlfdXBk
YXRlX2lyZWYoY29ubiwgd2FudF9pcmVmKTsKIH0KIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9mcy5oIGIvaW5jbHVkZS9saW51eC9mcy5oCmluZGV4IGU2YmEwY2M2ZjJlZS4uZGFjMzZmZTEz
OWUxIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2ZzLmgKKysrIGIvaW5jbHVkZS9saW51eC9m
cy5oCkBAIC0xMTczLDYgKzExNzMsNyBAQCBleHRlcm4gaW50IHNlbmRfc2lndXJnKHN0cnVjdCBm
b3duX3N0cnVjdCAqZm93bik7CiAjZGVmaW5lIFNCX0lfVFNfRVhQSVJZX1dBUk5FRCAweDAwMDAw
NDAwIC8qIHdhcm5lZCBhYm91dCB0aW1lc3RhbXAgcmFuZ2UgZXhwaXJ5ICovCiAjZGVmaW5lIFNC
X0lfUkVUSVJFRAkweDAwMDAwODAwCS8qIHN1cGVyYmxvY2sgc2hvdWxkbid0IGJlIHJldXNlZCAq
LwogI2RlZmluZSBTQl9JX05PVU1BU0sJMHgwMDAwMTAwMAkvKiBWRlMgZG9lcyBub3QgYXBwbHkg
dW1hc2sgKi8KKyNkZWZpbmUgU0JfSV9DT05URU5UX1dBVENIRUQgMHgwMDAwMjAwMCAvKiBmc25v
dGlmeSBmaWxlIGNvbnRlbnQgbW9uaXRvciAqLwogCiAvKiBQb3NzaWJsZSBzdGF0ZXMgb2YgJ2Zy
b3plbicgZmllbGQgKi8KIGVudW0gewpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mc25vdGlm
eS5oIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oCmluZGV4IDExZTY0MzRiOGU3MS4uMmUwZjQ3
NjQ4YThiIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5LmgKKysrIGIvaW5jbHVk
ZS9saW51eC9mc25vdGlmeS5oCkBAIC0xNyw2ICsxNywxMiBAQAogI2luY2x1ZGUgPGxpbnV4L3Ns
YWIuaD4KICNpbmNsdWRlIDxsaW51eC9idWcuaD4KIAorLyogQXJlIHRoZXJlIGFueSBpbm9kZS9t
b3VudC9zYiBvYmplY3RzIHRoYXQgYXJlIGJlaW5nIHdhdGNoZWQ/ICovCitzdGF0aWMgaW5saW5l
IGJvb2wgZnNub3RpZnlfc2JfaGFzX3dhdGNoZXJzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpCit7
CisJcmV0dXJuIGF0b21pY19sb25nX3JlYWQoJnNiLT5zX2Zzbm90aWZ5X2Nvbm5lY3RvcnMpOwor
fQorCiAvKgogICogTm90aWZ5IHRoaXMgQGRpciBpbm9kZSBhYm91dCBhIGNoYW5nZSBpbiBhIGNo
aWxkIGRpcmVjdG9yeSBlbnRyeS4KICAqIFRoZSBkaXJlY3RvcnkgZW50cnkgbWF5IGhhdmUgdHVy
bmVkIHBvc2l0aXZlIG9yIG5lZ2F0aXZlIG9yIGl0cyBpbm9kZSBtYXkKQEAgLTMwLDcgKzM2LDcg
QEAgc3RhdGljIGlubGluZSBpbnQgZnNub3RpZnlfbmFtZShfX3UzMiBtYXNrLCBjb25zdCB2b2lk
ICpkYXRhLCBpbnQgZGF0YV90eXBlLAogCQkJCXN0cnVjdCBpbm9kZSAqZGlyLCBjb25zdCBzdHJ1
Y3QgcXN0ciAqbmFtZSwKIAkJCQl1MzIgY29va2llKQogewotCWlmIChhdG9taWNfbG9uZ19yZWFk
KCZkaXItPmlfc2ItPnNfZnNub3RpZnlfY29ubmVjdG9ycykgPT0gMCkKKwlpZiAoIWZzbm90aWZ5
X3NiX2hhc193YXRjaGVycyhkaXItPmlfc2IpKQogCQlyZXR1cm4gMDsKIAogCXJldHVybiBmc25v
dGlmeShtYXNrLCBkYXRhLCBkYXRhX3R5cGUsIGRpciwgbmFtZSwgTlVMTCwgY29va2llKTsKQEAg
LTQ0LDcgKzUwLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGZzbm90aWZ5X2RpcmVudChzdHJ1Y3Qg
aW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LAogCiBzdGF0aWMgaW5saW5lIHZvaWQg
ZnNub3RpZnlfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwgX191MzIgbWFzaykKIHsKLQlpZiAo
YXRvbWljX2xvbmdfcmVhZCgmaW5vZGUtPmlfc2ItPnNfZnNub3RpZnlfY29ubmVjdG9ycykgPT0g
MCkKKwlpZiAoIWZzbm90aWZ5X3NiX2hhc193YXRjaGVycyhpbm9kZS0+aV9zYikpCiAJCXJldHVy
bjsKIAogCWlmIChTX0lTRElSKGlub2RlLT5pX21vZGUpKQpAQCAtNTksOSArNjUsNiBAQCBzdGF0
aWMgaW5saW5lIGludCBmc25vdGlmeV9wYXJlbnQoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBfX3Uz
MiBtYXNrLAogewogCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBkX2lub2RlKGRlbnRyeSk7CiAKLQlp
ZiAoYXRvbWljX2xvbmdfcmVhZCgmaW5vZGUtPmlfc2ItPnNfZnNub3RpZnlfY29ubmVjdG9ycykg
PT0gMCkKLQkJcmV0dXJuIDA7Ci0KIAlpZiAoU19JU0RJUihpbm9kZS0+aV9tb2RlKSkgewogCQlt
YXNrIHw9IEZTX0lTRElSOwogCkBAIC04NiwxOCArODksMTggQEAgc3RhdGljIGlubGluZSBpbnQg
ZnNub3RpZnlfcGFyZW50KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgX191MzIgbWFzaywKICAqLwog
c3RhdGljIGlubGluZSB2b2lkIGZzbm90aWZ5X2RlbnRyeShzdHJ1Y3QgZGVudHJ5ICpkZW50cnks
IF9fdTMyIG1hc2spCiB7CisJaWYgKCFmc25vdGlmeV9zYl9oYXNfd2F0Y2hlcnMoZGVudHJ5LT5k
X3NiKSkKKwkJcmV0dXJuOworCiAJZnNub3RpZnlfcGFyZW50KGRlbnRyeSwgbWFzaywgZGVudHJ5
LCBGU05PVElGWV9FVkVOVF9ERU5UUlkpOwogfQogCiBzdGF0aWMgaW5saW5lIGludCBmc25vdGlm
eV9maWxlKHN0cnVjdCBmaWxlICpmaWxlLCBfX3UzMiBtYXNrKQogewotCWNvbnN0IHN0cnVjdCBw
YXRoICpwYXRoOwotCiAJaWYgKGZpbGUtPmZfbW9kZSAmIEZNT0RFX05PTk9USUZZKQogCQlyZXR1
cm4gMDsKIAotCXBhdGggPSAmZmlsZS0+Zl9wYXRoOwotCXJldHVybiBmc25vdGlmeV9wYXJlbnQo
cGF0aC0+ZGVudHJ5LCBtYXNrLCBwYXRoLCBGU05PVElGWV9FVkVOVF9QQVRIKTsKKwlyZXR1cm4g
ZnNub3RpZnlfcGF0aCgmZmlsZS0+Zl9wYXRoLCBtYXNrKTsKIH0KIAogLyoKZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oIGIvaW5jbHVkZS9saW51eC9mc25vdGlm
eV9iYWNrZW5kLmgKaW5kZXggN2Y2M2JlNWNhMGYxLi40ZTA5OGJkZWIzY2EgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oCisrKyBiL2luY2x1ZGUvbGludXgvZnNu
b3RpZnlfYmFja2VuZC5oCkBAIC02Niw2ICs2NiwxMSBAQAogI2RlZmluZSBGU19SRU5BTUUJCTB4
MTAwMDAwMDAJLyogRmlsZSB3YXMgcmVuYW1lZCAqLwogI2RlZmluZSBGU19ETl9NVUxUSVNIT1QJ
CTB4MjAwMDAwMDAJLyogZG5vdGlmeSBtdWx0aXNob3QgKi8KICNkZWZpbmUgRlNfSVNESVIJCTB4
NDAwMDAwMDAJLyogZXZlbnQgb2NjdXJyZWQgYWdhaW5zdCBkaXIgKi8KKy8qCisgKiBUaGlzIGZs
YWcgaXMgc2V0IGluIHRoZSBvYmplY3QgaW50ZXJlc3QgbWFzayBvZiBzYiB0byBpbmRpY2F0ZSB0
aGF0CisgKiBzb21lIG1vdW50IG1hcmsgaXMgaW50ZXJlc3RlZCB0byBnZXQgY29udGVudCBldmVu
dHMuCisgKi8KKyNkZWZpbmUgRlNfTU5UX0NPTlRFTlRfV0FUQ0hFRAkweDgwMDAwMDAwCiAKICNk
ZWZpbmUgRlNfTU9WRQkJCShGU19NT1ZFRF9GUk9NIHwgRlNfTU9WRURfVE8pCiAKQEAgLTc3LDYg
KzgyLDEzIEBACiAgKi8KICNkZWZpbmUgQUxMX0ZTTk9USUZZX0RJUkVOVF9FVkVOVFMgKEZTX0NS
RUFURSB8IEZTX0RFTEVURSB8IEZTX01PVkUgfCBGU19SRU5BTUUpCiAKKy8qIENvbnRlbnQgZXZl
bnRzIGNhbiBiZSB1c2VkIHRvIGluc3BlY3QgZmlsZSBjb250ZW50ICovCisjZGVmaW5lIEZTTk9U
SUZZX0NPTlRFTlRfUEVSTV9FVkVOVFMJKEZTX0FDQ0VTU19QRVJNKQorCisvKiBDb250ZW50IGV2
ZW50cyBjYW4gYmUgdXNlZCB0byBtb25pdG9yIGZpbGUgY29udGVudCAqLworI2RlZmluZSBGU05P
VElGWV9DT05URU5UX0VWRU5UUwkJKEZTX0FDQ0VTUyB8IEZTX01PRElGWSB8IFwKKwkJCQkJIEZT
Tk9USUZZX0NPTlRFTlRfUEVSTV9FVkVOVFMpCisKICNkZWZpbmUgQUxMX0ZTTk9USUZZX1BFUk1f
RVZFTlRTIChGU19PUEVOX1BFUk0gfCBGU19BQ0NFU1NfUEVSTSB8IFwKIAkJCQkgIEZTX09QRU5f
RVhFQ19QRVJNKQogCkBAIC01NDEsNiArNTUzLDcgQEAgc3RydWN0IGZzbm90aWZ5X21hcmsgewog
ZXh0ZXJuIGludCBmc25vdGlmeShfX3UzMiBtYXNrLCBjb25zdCB2b2lkICpkYXRhLCBpbnQgZGF0
YV90eXBlLAogCQkgICAgc3RydWN0IGlub2RlICpkaXIsIGNvbnN0IHN0cnVjdCBxc3RyICpuYW1l
LAogCQkgICAgc3RydWN0IGlub2RlICppbm9kZSwgdTMyIGNvb2tpZSk7CitleHRlcm4gaW50IGZz
bm90aWZ5X3BhdGgoY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsIF9fdTMyIG1hc2spOwogZXh0ZXJu
IGludCBfX2Zzbm90aWZ5X3BhcmVudChzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIF9fdTMyIG1hc2ss
IGNvbnN0IHZvaWQgKmRhdGEsCiAJCQkgICBpbnQgZGF0YV90eXBlKTsKIGV4dGVybiB2b2lkIF9f
ZnNub3RpZnlfaW5vZGVfZGVsZXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUpOwotLSAKMi4zNC4xCgo=
--00000000000037cf98060ebf406e--

