Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668406FE473
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 21:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjEJTV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEJTV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 15:21:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4AA1BB;
        Wed, 10 May 2023 12:21:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f315712406so259608955e9.0;
        Wed, 10 May 2023 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683746513; x=1686338513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=75/PwaQlinYnE7/rv9/UmLf1WnSuqFFPMVv591KTD7I=;
        b=VL5LqX9jZvqzsKq/MZ2TrkHso6ahpt9YJyAJxEKSq9PN7NIB/j0Uii8VhozyTa8Zzk
         T3iwjr0garPVqfUr5nW6rbLU/ACLqwDXninWG3vbqaqsOl4eqvgh0yv6TX1eTOlopKGO
         gF2mxvsP/deDYgKW2cj53x/DZY9HDotNFkAINsD9hhRx3OtHfcZio2N5p78xGeTmCp9G
         3gRMsOHHAhgfzbKKYNdF8pqSkCYglnKfEhf15BJFUCE+PSuMmAAIK292RvsBkY8WPLvd
         sXI7OZhiG0YDCoylD7Lgrx26D7ZWWZ9zdkTk9gaqhzANDMcbwttFnIWLXz7i6YAWzpN1
         /2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683746513; x=1686338513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75/PwaQlinYnE7/rv9/UmLf1WnSuqFFPMVv591KTD7I=;
        b=GD+kVPd0G5s7Ho1b76DHwm9q1yma6VE74wTwnfssRckR0hy9lbTNT1x9wqlLsC8jIk
         vPg99PGXcFlwqLCq/1OkoIqdqft+oDmiG7upNOk865eYI7xMFf3DbMUoA1wTZyseYav4
         uG0xiVsrXEf4WRSHuXQkXe7y/8yQMPbPQUsxYh+GVM/0py7Ok5XIO0vvHYHaM9dtZjaN
         MKS8q+EKq2UpoVxIedb4Z0DK6U+TfLJ9vZvSb2caIHMOTa/VAkDjKoi7IATtHJRsMMy+
         AN1VkWD27kbJDYsVXRNpv5+1c3vlSdQu3Y9iZBbQPi16DwV6M6mJDgbRTbdqf6vb1bJk
         8EZg==
X-Gm-Message-State: AC+VfDzrjn5nQn2m3cF9bf3ygH4MSokS1Je2XI3nseulA4jZ38MEZp+a
        IyJTLpV9LXH9xEusSQj6GTM=
X-Google-Smtp-Source: ACHHUZ5DmOt4GSXJ+gAkY2jMf5Y85rkrkVed4nfe6h9v3ltjknQEtzqxWwt3aAD01083hCQcSVtjTg==
X-Received: by 2002:a05:6000:114b:b0:307:8a39:555f with SMTP id d11-20020a056000114b00b003078a39555fmr10111877wrx.17.1683746512933;
        Wed, 10 May 2023 12:21:52 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:9d6a:15a4:c7d1:a0f0])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b003075428aad5sm17959526wrr.29.2023.05.10.12.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 12:21:52 -0700 (PDT)
Date:   Wed, 10 May 2023 21:21:38 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Jeff Xu <jeffxu@google.com>
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC 0/4] Landlock: ioctl support
Message-ID: <20230510.c667268d844f@gnoack.org>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
 <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cb74c81-3c88-6569-5aff-154b8cf626fa@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Mickaël!

Sorry for the late reply.  This was indeed a bit difficult for me to
understand; maybe it just needs more clarification.

Let me try to paraphrase your proposal (inline below) so we can
resolve the misunderstandings.


On Thu, May 04, 2023 at 11:12:00PM +0200, Mickaël Salaün wrote:
> Thanks for this RFC, this is interesting!
> 
> I previously thought a lot about IOCTLs restrictions and here are some
> notes:
> 
> IOCTLs are everywhere, from devices to filesystems (see fscrypt). Each
> different file type may behave differently for the same IOCTL command/ID. It
> is also worth noting that there are a lot of different IOCTLs, they are
> growing over time, some might be dedicated to get some data (i.e. read) and
> others to change the state of a device (i.e. write), some might be innocuous
> (e.g. FIOCLEX, FIONCLEX) and others potentially harmful. _IOC_READ and
> _IOC_WRITE can be useful but they are not mandatory, there are exceptions,
> and it may be difficult to identify if a command pertains to one, the other,
> or both kind of actions.
> 
> I then think it would be very useful to be able to tie file/device types to
> a set of IOCTLs, letting user space libraries define and classify the IOCTL
> semantic.
> 
> Instead of relying on a LANDLOCK_ACCESS_FS_IOCTL which would allow or deny
> all IOCTLs, we can extend the path_beneath struct to manage IOCTLs in
> addition to regular file accesses. Because dealing with a set of IOCTLs
> would imply to deal with a lot of data and combinations, I thought about
> creating groups of IOCTLs (defining access semantic) that could be matched
> against file hierarchies. The composability nature of Landlock domains is
> also another constraint to keep in mind.
> 
> // New rule type dedicated to define groups of IOCTLs.
> struct landlock_ioctl_attr {
>   __u32 command; // IOCTL number/ID
>   dev_t device; // must be 0 for regular file and directory
>   __u8 file_type;
>   __u8 id_mask; // if 0, then applied globally
> };
>
> We could use landlock_add_rule(2) to fill a set of landlock_ioctl_attr into
> a ruleset and use them with landlock_path_beneath_attr entries:
> 
> // LANDLOCK_RULE_PATH_BENEATH, leveraging the extensible design of
> // landlock_path_beneath_attr, hence the same first fields.
> struct landlock_path_beneath_attr {
>   __u64 allowed_access;
>   __s32 parent_fd;
>   __u16 allowed_ioctl_id_mask;
> };
> 
> landlock_ioctl_attr includes a 8-bit mask for which each bit identifies a
> set of allowed IOCTLs per device/file type. This mask is then tied to a
> path_beneath_attr. We cannot use number IDs because of dev_t+IOCTL->ID
> intersection conflicts. Using an id_mask enables to group (specific) IOCTLs
> together, then creating synthetic access rights.
> 
> When merging a ruleset with a domain, each IOCTL ID mask is shifted and ORed
> with the other layer ones to get a (8*16) 128-bit mask, stored in an
> IOCTL/dev_t table and in the related landlock_object. When looking for an
> IOCTL request, Landlock first looks into the IOCTL set ID table and get the
> global set ID mask, which kind of translates to a composition of synthetic
> access rights (stored with the landlock_layer.ioctl_access bitmask). We then
> walk through all the inodes to match the whole mask.
> 
> I realize that this is complex and this explanation might be confusing
> though. What do you think?

To be honest, I am not fully sure I understand the landlock_ioctl_attr
struct correctly.

My current guess is:

  command:   a single ioctl request number that should be permitted

  device:    if device != 0; require the dev_t (major+minor number)
             of the file to match, before permitting the ioctl

  file_type: if set (!= 0?), require the file type to match,
             before permitting the ioctl

  id_mask:   Indicates the IDs of the groups where this ioctl
             should be permitted(?)

So -- if we were to implement this without any optimizations -- the
logic of this is presumably something like this?:

  If Landlock checks an ioctl with a request_id on a file f:

  We look up the allowed_ioctl_id_mask and loop over the bits set in
  that mask.

  For every bit set in that mask, we look up the matching ioctl group.
  Within the group, we look whether we can find a landlock_ioctl_attr
  rule that belongs to the group which permits that ioctl request.

  The request is granted by a landlock_ioctl_attr if:

    attr.command == request_id
    && (attr.device == 0 || file_inode(file).i_rdev == attr.device)
    && (attr.file_type == 0 || landlock_get_file_type?(file))

Is this roughly what you imagined?


Some specific things I don't understand well are:

* How does id_mask identify the ioctl group?  Do you envision an
  interface where you can add a landlock_ioctl_attr to multiple groups
  at once?

  When the added landlock_ioctl_attr has id_mask=3, does it add that
  attr to group 2 and 1?

* How does allowed_ioctl_id_mask match against the ioctl group IDs
  (id_mask)?  I'm particularly confused because the
  allowed_ioctl_id_mask is __u16, whereas id_mask is __u8?  Is this
  intentional?

* What is file_type?  Are those the file types as used in mknod(2),
  so that you can distinguish between regular files, directories,
  named pipes and the like?

* If I understand the proposal right, the .device and .file_type in
  landlock_ioctl_attr are narrowing down the set of files that the
  ioctl policy applies to.  In all rules up until Landlock v3, which
  we already have, the selection of the files which the rule applies
  to is purely done based on file hierarchy.

  Would it not be a more orthogonal API if the "file selection" part
  of the Landlock API and the "policy adding" part for these selected
  files were independent of each other?  Then the .device and
  .file_type selection scheme could be used for the existing policies
  as well?

* When restricting by dev_t (major and minor number), aren't there use
  cases where a system might have 256 CDROM drives, and you'd need to
  allow-list all of these minor number combinations?

* Aren't many ioctl use cases already usable with just the proposal I
  made?  If you add a rule to permit IOCTL for /dev/cdrom0, that
  opened file will anyway only expose a small subset of the ioctls
  that the kernel as a whole offers, no?  Are there ioctls which are
  offered independent of the file type which I'm overlooking? (Sorry,
  this might be a naive question. :))


> On 02/05/2023 19:17, Günther Noack wrote:
> > Alternatives considered: Allow-listing specific ioctl requests
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > It would be technically possible to keep an allow-list of ioctl
> > requests and thereby control in more detail which ioctls should work.
> > 
> > I believe that this is not needed for the majority of use cases and
> > that it is a reasonable trade-off to make here (but I'm happy to hear
> > about counterexamples).  The reasoning is:
> > 
> > * Many programs do not need ioctl at all,
> >    and denying all ioctl(2) requests OK for these.
> > 
> > * Other programs need ioctl, but only for the terminal FDs.
> >    This is supported because these file descriptors are usually
> >    inherited from the parent process - so the parent process gets to
> >    control the ioctl(2) policy for them.
> > 
> > * Some programs need ioctl on specific files that they are opening
> >    themselves.  They can allow-list these file paths for ioctl(2).
> >    This makes the programs work, but it restricts a variety of other
> >    ioctl requests which are otherwise possible through opening other
> >    files.
> > 
> > Because the LANDLOCK_ACCESS_FS_IOCTL right is attached to the file
> > descriptor, programs have flexible options to control which ioctl
> > operations should work, without the implementation complexity of
> > additional ioctl allow-lists in the kernel.
> > 
> > Finally, the proposed approach is simpler in implementation and has
> > lower API complexity, but it does *not* preclude us from implementing
> > per-ioctl-request allow lists later, if that turns out to be necessary
> > at a later point.
> 
> I value this simplicity, but I'm also wondering about how much this
> allow/deny all IOCTLs approach would be useful in real case scenarios. ;)

Mickaël, would you be open to gather some more data for this from
existing users, to understand better which use cases they have?

(Looking in the direction of Jeff Xu, who has inquired about Landlock
for Chromium in the past -- do you happen to know in which ways you'd
want to restrict ioctls, if you have that need? :))


> > Related Work
> > ~~~~~~~~~~~~
> > 
> > OpenBSD's pledge(2) [1] restricts ioctl(2) independent of the file
> > descriptor which is used.  The implementers maintain multiple
> > allow-lists of predefined ioctl(2) operations required for different
> > application domains such as "audio", "bpf", "tty" and "inet".
> > 
> > OpenBSD does not guarantee ABI backwards compatibility to the same
> > extent as Linux does, so it's easier for them to update these lists in
> > later versions.  It might not be a feasible approach for Linux though.
> > 
> > [1] https://man.openbsd.org/OpenBSD-7.3/pledge.2
> > 
> > Feedback I'm looking for
> > ~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Some specific points I would like to get your opinion on:
> > 
> > * Is this the right general approach to restricting ioctl(2)?
> > 
> >    It will probably be possible to find counter-examples where the
> >    alternative (see below) is better.  I'd be interested in these, and
> >    in how common they are, to understand whether we have picked the
> >    right trade-off here.
> 
> In the long term, I'd like Landlock to be able to restrict a set of IOCTLs,
> taking into account the type of file/device. Being able to deny all IOCTLs
> might be useful and is much easier to implement though.

In my mind, it's a trade-off between implementation complexity and
flexibility.

My proposal is more simple-minded than what you explained, but might
solve the bulk of real-life use cases for a lower implementation
complexity. (With the caveat that I don't understand the real life use
cases well enough to know how far it really gets us, that's why this
is just an RFC.)

I'm not *just* saying this because I'm lazy ;), but I also feel that
we should be careful with the amount of complexity that we take on,
especially if there is a chance that it won't be needed in practice.

I think that it might be a feasible approach to start with the
LANDLOCK_ACCESS_FS_IOCTL approach and then look at its usage to
understand whether we see a significant number of programs whose
sandboxes are too coarse because of this.

If more fine-granular control is needed, we can still put the other
approach on top, and the additional complexity from
LANDLOCK_ACCESS_FS_IOCTL that we have to support is not that
dramatically high.

If more fine-granular control is not needed, we can skip the
implementation of the other approach and Landlock is simpler.

Then again, I'm somewhat new to kernel development still, I'm not sure
whether this is an approach that is deemed acceptable in this setting?


> > * Should we introduce a "landlock_fd_rights_limit()" syscall?
> > 
> >    We could potentially implement a system call for dropping the
> >    LANDLOCK_ACCESS_FS_IOCTL and LANDLOCK_ACCESS_FS_TRUNCATE rights from
> >    existing file descriptors (independent of the type of file
> >    descriptor, even).
> > 
> >    Possible use cases would be to (a) restrict the rights on inherited
> >    file descriptors like std{in,out,err} and to (b) restrict ioctl and
> >    truncate operations on file descriptors that are not acquired
> >    through open(2), such as network sockets.
> > 
> >    This would be similar to the cap_rights_limit(2) system call in
> >    FreeBSD's Capsicum.
> > 
> >    This idea feels somewhat orthogonal to the ioctl patch, but it would
> >    start to be more useful if the ioctl right exists.
> 
> This is indeed interesting, and that should be useful for the cases you
> explained. I think supporting IOCTLs is more important for now, but a new
> syscall to restrict FDs could be useful in the future.

Ack, OK.  I agree, it's not that urgent yet.


> We should also think about batch operations on FD (see the
> close_range syscall), for instance to deny all IOCTLs on inherited
> or received FDs.

Hm, you mean a landlock_fd_rights_limit_range() syscall to limit the
rights for an entire range of FDs?

I have to admit, I'm not familiar with the real-life use cases of
close_range().  In most programs I work with, it's difficult to reason
about their ordering once the program has really started to run. So I
imagine that close_range() is mostly used to "sanitize" the open file
descriptors at the start of main(), and you have a similar use case in
mind for this one as well?

If it's just about closing the range from 0 to 2, I'm not sure it's
worth adding a custom syscall. :)

Thanks for the review!
–Günther
