Return-Path: <linux-fsdevel+bounces-6664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0329781B4B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF930286B81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA46ABAD;
	Thu, 21 Dec 2023 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWEaJQcu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D976AB9F
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67ac0ef6bb8so3120556d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 03:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703157296; x=1703762096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nCCS9wuEV9mayYgN2ZuybimgL+Rqoihf4Ec4MrAqp0=;
        b=BWEaJQcub9mPykm4heAzXXhwdIsdsHMJRqJu0tE1GIu45m3w40tgocOkaEuHR/mlF7
         7aTFHaR5nsUW2hbEKd9bHKqNEpKYEjqO90NfGu3zWRPWAcC0TrY9qfBXsGWKmHFgdyWZ
         JnQnlYE2i+hdsC4Qkw0f7cHqMFEHc38YpCw1XBlm02eG1EgsTWDrBv/SsRuKMi9y2Q0H
         YsLphhsS6bSXjRRK7IIyxWJ/nGIxNgXFg0FHs8BOm9Lzut/olJowvR/Ugqj32e3vkwAD
         wPtV1hlCWwS1F8VIyF4ybRGUD+iL3ly5UDq88YJCYfJRv9yxBRB3q0s0JhHF/Rjfr9L8
         fKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703157296; x=1703762096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nCCS9wuEV9mayYgN2ZuybimgL+Rqoihf4Ec4MrAqp0=;
        b=cD8ssvoCQW3AKqBd2+/NGJ7iyCSYJMAvK1AJQ7mKwTHMQXkZ0QvAxlB9B07Cjl6UVb
         CMnOw8aWEcK+omMQc1bNCAjySmXXEMJzQJTSCcF5xvL9XD4kgouhwKdCzk1Dq7FSov2V
         hHO5PRlPe7LKUsnPjAiZvdf0ouMfeKDTreMgy8HTZkz2r/WR1S8DkBxgWdzp9BBno8Kp
         z/GE75U5kK/vjy1mGxul8g8/nboD06aDHypEG7LFPwkQrxLjNybft3Y3FpdkoICd9BUv
         gF3hdNHsWMu2jmfLBX2X7HT02sZsd4H5TUaBSx8etZ52cyIxb2YCrrVcl14STT+cfLj6
         6ybA==
X-Gm-Message-State: AOJu0YzufCCNEKakvl0dqf8x6j7yn8R31hV2pbZICfm3HZdjUD73V7MF
	wbMNKGzVkICuy437gvn4twqHjAHSLEvaVcnKVjw=
X-Google-Smtp-Source: AGHT+IF+UjU45Wpjg5TgG36PBUkYtoqphdR625W7U92RHicspA+84SR4FlMCsAGaDUSwmQzzA3ZQJ2yUxU2gLvIojiM=
X-Received: by 2002:ad4:5aa2:0:b0:67f:12bb:6c06 with SMTP id
 u2-20020ad45aa2000000b0067f12bb6c06mr16518879qvg.36.1703157295616; Thu, 21
 Dec 2023 03:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920024001.493477-1-tfanelli@redhat.com> <CAOQ4uxhucqtjycyTd=oJF7VM2VQoe6a-vJWtWHRD5ewA+kRytw@mail.gmail.com>
 <8e76fa9c-59d0-4238-82cf-bfdf73b5c442@fastmail.fm> <CAOQ4uxjKbQkqTHb9_3kqRW7BPPzwNj--4=kqsyq=7+ztLrwXfw@mail.gmail.com>
 <6e9e8ff6-1314-4c60-bf69-6d147958cf95@fastmail.fm> <CAOQ4uxiJfcZLvkKZxp11aAT8xa7Nxf_kG4CG1Ft2iKcippOQXg@mail.gmail.com>
 <06eedc60-e66b-45d1-a936-2a0bb0ac91c7@fastmail.fm> <CAOQ4uxhRbKz7WvYKbjGNo7P7m+00KLW25eBpqVTyUq2sSY6Vmw@mail.gmail.com>
 <7c588ab3-246f-4d9d-9b84-225dedab690a@fastmail.fm> <CAOQ4uxgb2J8zppKg63UV88+SNbZ+2=XegVBSXOFf=3xAVc1U3Q@mail.gmail.com>
 <9d3c1c2b-53c0-4f1d-b4c0-567b23d19719@fastmail.fm> <CAOQ4uxhd9GsWgpw4F56ACRmHhxd6_HVB368wAGCsw167+NHpvw@mail.gmail.com>
 <2d58c415-4162-441e-8887-de6678b2be28@fastmail.fm> <98795992-589d-44cb-a6d0-ccf8575a4cc4@fastmail.fm>
 <c4c87b07-bcae-4c6e-aaec-86168db7804a@fastmail.fm> <CAOQ4uxgy5mV4aP4YHJtoYeeLMzNfj0qYh7zTL32gO1TfJDvYYg@mail.gmail.com>
 <bde78295-e455-4315-b8c6-57b0d3b60c6c@fastmail.fm>
In-Reply-To: <bde78295-e455-4315-b8c6-57b0d3b60c6c@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Dec 2023 13:14:43 +0200
Message-ID: <CAOQ4uxjmg0ixS58aacwuYKXhVMyh+O-PmOtgxQR1wd+Ab25r1w@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com, 
	hreitz@redhat.com, Hao Xu <howeyxu@tencent.com>, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:17=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 12/21/23 10:18, Amir Goldstein wrote:
> > On Thu, Dec 21, 2023 at 12:13=E2=80=AFAM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >>
> >>
> >>
> >> [...]
> >>
> >>>>>>> I think that we are going to need to use some inode state flag
> >>>>>>> (e.g. FUSE_I_DIO_WR_EXCL) to protect against this starvation,
> >>>>>>> unless we do not care about this possibility?
> >>>>>>> We'd only need to set this in fuse_file_io_mmap() until we get
> >>>>>>> the iocachectr refcount.
> >>
> >>
> >> I added back FUSE_I_CACHE_IO_MODE I had used previously.
> >>
> >
> > ACK.
> > Name is a bit confusing for the "want io mode" case, but IMO
> > a comment would be enough to make it clear.
> > Push a version with a comment to my branch.
> >
> >
> >>
> >>>>>>>
> >>>>>>> I *think* that fuse_inode_deny_io_cache() should be called with
> >>>>>>> shared inode lock held, because of the existing lock chain
> >>>>>>> i_rwsem -> page lock -> mmap_lock for page faults, but I am
> >>>>>>> not sure. My brain is too cooked now to figure this out.
> >>>>>>> OTOH, I don't see any problem with calling
> >>>>>>> fuse_inode_deny_io_cache() with shared lock held?
> >>>>>>>
> >>>>>>> I pushed this version to my fuse_io_mode branch [1].
> >>>>>>> Only tested generic/095 with FOPEN_DIRECT_IO and
> >>>>>>> DIRECT_IO_ALLOW_MMAP.
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Amir.
> >>>>>>>
> >>>>>>> [1] https://github.com/amir73il/linux/commits/fuse_io_mode
> >>>>>>
> >>>>>> Thanks, will look into your changes next. I was looking into the
> >>>>>> initial
> >>>>>> issue with generic/095 with my branch. Fixed by the attached patch=
. I
> >>>>>> think it is generic and also applies to FOPEN_DIRECT_IO + mmap.
> >>>>>> Interesting is that filemap_range_has_writeback() is exported, but
> >>>>>> there
> >>>>>> was no user. Hopefully nobody submits an unexport patch in the mea=
n
> >>>>>> time.
> >>>>>>
> >>>>>
> >>>>> Ok. Now I am pretty sure that filemap_range_has_writeback() should =
be
> >>>>> check after taking the shared lock in fuse_dio_lock() as in my bran=
ch
> >>>>> and
> >>>>> not in fuse_dio_wr_exclusive_lock() outside the lock.
> >>>>
> >>>>
> >>>>
> >>>>>
> >>>>> But at the same time, it is a little concerning that you are able t=
o
> >>>>> observe
> >>>>> dirty pages on a fuse inode after success of fuse_inode_deny_io_cac=
he().
> >>>>> The whole point of fuse_inode_deny_io_cache() is that it should be
> >>>>> granted after all users of the inode page cache are gone.
> >>>>>
> >>>>> Is it expected that fuse inode pages remain dirty after no more ope=
n
> >>>>> files
> >>>>> and no more mmaps?
> >>>>
> >>>>
> >>>> I'm actually not sure anymore if filemap_range_has_writeback() is
> >>>> actually needed. In fuse_flush() it calls write_inode_now(inode, 1),
> >>>> but I don't think that will flush queued fi->writectr
> >>>> (fi->writepages). Will report back in the afternoon.
> >>>
> >>> Sorry, my fault, please ignore the previous patch. Actually no dirty
> >>> pages to be expected, I had missed the that fuse_flush calls
> >>> fuse_sync_writes(). The main bug in my branch was due to the differen=
t
> >>> handling of FOPEN_DIRECT_IO and O_DIRECT - for O_DIRECT I hadn't call=
ed
> >>> fuse_file_io_mmap().
> >
> > But why would you need to call fuse_file_io_mmap() for O_DIRECT?
> > If a file was opened without FOPEN_DIRECT_IO, we already set inode to
> > caching mode on open.
> > Does your O_DIRECT patch to mmap solve an actual reproducible bug?
>
> Yeah it does, in my fuse-dio-v5 branch, which adds in shared locks for
> O_DIRECT writes without FOPEN_DIRECT_IO.
>

Ah. right, because open(O_DIRECT) does not enter io cache mode
in your branch. I missed that.

But still, I think that a better fix for fuse_io_mode would be to treat
mmap of O_DIRECT exactly the same as mmap of FOPEN_DIRECT_IO,
including invalidate page cache and require FUSE_DIRECT_IO_ALLOW_MMAP.
I know this could be a change of behavior of applications doing mmap()
on an fd that was opened with O_DIRECT, but I doubt that such applications
exist, even if this really works with upstream code.

Something like this (pushed to my fuse_io_mode branch)?

+static bool fuse_file_is_direct_io(struct file *file)
+{
+       struct fuse_file *ff =3D file->private_data;
+
+       return ff->open_flags & FOPEN_DIRECT_IO || file->f_flags & O_DIRECT=
;
+}
+
 /* Request access to submit new io to inode via open file */
 static bool fuse_file_io_open(struct file *file, struct inode *inode)
 {
@@ -116,7 +121,7 @@ static bool fuse_file_io_open(struct file *file,
struct inode *inode)
                return true;

        /* Set explicit FOPEN_CACHE_IO flag for file open in caching mode *=
/
-       if (!(ff->open_flags & FOPEN_DIRECT_IO) && !(file->f_flags & O_DIRE=
CT))
+       if (!fuse_file_is_direct_io(file))
                ff->open_flags |=3D FOPEN_CACHE_IO;

        spin_lock(&fi->lock);
@@ -2622,8 +2627,9 @@ static int fuse_file_mmap(struct file *file,
struct vm_area_struct *vma)
        if (FUSE_IS_DAX(file_inode(file)))
                return fuse_dax_mmap(file, vma);

-       if (ff->open_flags & FOPEN_DIRECT_IO) {
-               /* Can't provide the coherency needed for MAP_SHARED
+       if (fuse_file_is_direct_io(file)) {
+               /*
+                * Can't provide the coherency needed for MAP_SHARED
                 * if FUSE_DIRECT_IO_ALLOW_MMAP isn't set.
                 */


> >
> >>
> >>
> >> I pushed a few fixes/updates into my fuse-dio-v5 branch and also to
> >> simplify it for you to my fuse_io_mode branch. Changes are onto of the
> >> previous patches io-mode patch to simplify it for you to see the chang=
es
> >> and to possibly squash it into the main io patch.
> >>
> >> https://github.com/bsbernd/linux/commits/fuse_io_mode/
> >>
> >
> > Cool. I squashed all your fixes to my branch, with minor comments
> > that I also left on github, except for the O_DIRECT patch, because
> > I do not understand why it is needed.
>
> No issue with that, I can keep that patch on the branch that actually
> needs it.
>
> Oh, I just see your comments - I didn't get github notification and so
> missed your comments before. Sorry about that. Checking where I need to
> enable it. I do get notifications for other projects, so didn't suspect
> that anything would be missing...
>
>
> >
> > The 6.8 merge window is very close and the holidays are upon us,
> > so not sure if you and Miklos could be bothered, but do you think there
> > is  a chance that we can get fuse_io_mode patches ready for queuing
> > in time for the 6.8 merge window?
> >
> > They do have merit on their own for re-allowing parallel dio along with
> > FOPEN_PARALLEL_DIRECT_WRITES, but also, it would make it easier
> > for the both of us to develop fuse-dio and fuse-passthrough based on
> > the io cache mode during the 6.9 dev cycle.
>
> I definitely would also like to get these patches in. Holidays have the
> merit that I don't need to get up at 7am to wake up kids and am then
> tired all the day. And no meetings ;)
>

I think that between you and I, fuse_io_mode is getting very close to
converging, so queuing it for 6.8 really depends on Miklos' availability
during the following week.

I suggest that you incorporate my review comments from github
and/or use the patches that I pushed to my fuse_io_mode branch
and post the io mode patches for review on the list as soon as
possible. I could do that, but I trust that you are testing dio much
better than I am.

>  From my point my dio-v5 branch is also ready, it relies on these
> patches. Not sure how to post it with the dependency.

Basically, you just post the io mode patch set and then you
post the dio patches with a reference to the io mode patches
that they depend on.

> I also have no issue to wait for 6.9, for now I'm going to take these
> patches to our fuse module for ubuntu and rhel9 kernels (quite heavily
> patched, as it needs to live aside the kernel included module - symbol
> renames, etc).
>

Feels to me like the dio patches are a bit heavier to review than just the
io mode patches, so not likely to be ready for 6.8, but it's not up to me.
I can only say that my review of io mode patches is done and that I have
tested them, while my own ability to review fuse-dio patches for the 6.8
timeframe is limited.

Thanks,
Amir.

