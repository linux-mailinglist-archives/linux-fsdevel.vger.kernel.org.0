Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA36D379EC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 06:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhEKEqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 00:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhEKEqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 00:46:31 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7986C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 21:45:25 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q136so17626540qka.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 21:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RgsP3mtWSjyYBcXaoh9mVAeLsQnVxRohB+i2diO386s=;
        b=dDBG0mei9AZjr2vjNp826ZZFLbxURrTN3TLMkBymH48U5J4c9igaYLKuI+RTxUNE+m
         Tb4jiXmmX7XDfaZbFr24bJcLKpusUpz7O9vTQIpa307o/pXECvNSj7s2/AV6KzFu2kTX
         ETXwAcgNXr5Q+DzrREu+hx5YyK0x1G2DZEtgkrUwbl1hoK47CssboT0z/vvfjPooMMwX
         BABwF0HxAwwgnRjyi9oyKZ6HtpXfVQl3I3NtceJFfrN1m8HRBBxESoSrIxFGWJHtXeWv
         yU8o3N8HKrRXE0ZgpjLd+zTVR8xqF9Z6YrI1ApJ5dWUYy0fwBlG+FuuaYrgu6XUbd4Lp
         jz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgsP3mtWSjyYBcXaoh9mVAeLsQnVxRohB+i2diO386s=;
        b=CERFUbmuStPPSeOhduz4hzF4jivLSS0PEv8IXwmqV5ODkHI8tuZW5W7R9W6ADeGUWl
         IF3hoXyXbck+sfOE5iwDWWKtb/+sN4q0Uhu9gMHbi5W1sHKD29qua7ZUYym7j4CwYWO+
         jq3poA7shRJQFznoQLt0y4PpSL65h5diWO/vhouILmgJsy2r7aSM6sKcyjD2yrgGTdDW
         gTsrd6WzED1jw7rWCL0I3KnWAnMg+jj44dh/qM5K3OIE/6t9rZOPJg4Ulq806Jywnxee
         x0pXlb9OpjXIMeLLQAFNqo/jDujzrRuRIKTdywTSZKWcphHoOLCGH36goNchbE/InvJQ
         O63w==
X-Gm-Message-State: AOAM530Fgvsqv73Rf8reeNMjINHSI+vRFY5RYzf41fw8zkq6N3WAym9u
        blZrq6LIVzbiN6+HlJXjUlc/wOREzfNe3tsC4GntzA==
X-Google-Smtp-Source: ABdhPJyLITHKYiw4rxzBMxeptKoXWX7A6mTb18ICmcf/bdM6881VE3eaR/YkzAep2HdyyPn3jMU9dHkXUudOLc2dbRU=
X-Received: by 2002:ae9:e884:: with SMTP id a126mr26128487qkg.421.1620708324609;
 Mon, 10 May 2021 21:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com>
 <CAOQ4uxi3yigb2gUjXHJQOVbPHR3RFDeyKc5i0X-k8CSLwurejg@mail.gmail.com> <875z0791ga.fsf@collabora.com>
In-Reply-To: <875z0791ga.fsf@collabora.com>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Mon, 10 May 2021 21:45:13 -0700
Message-ID: <CACGdZYJi=mG4=ADpHsHzAUBwCX6UfdtNvDSZNfV0PNL_MgCi7Q@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] File system wide monitoring
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000002194605c2069036"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000002194605c2069036
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 27, 2021 at 8:44 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Mon, Apr 26, 2021 at 9:42 PM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> Hi,
> >>
> >> In an attempt to consolidate some of the feedback from the previous
> >> proposals, I wrote a new attempt to solve the file system error reporting
> >> problem.  Before I spend more time polishing it, I'd like to hear your
> >> feedback if I'm going in the wrong direction, in particular with the
> >> modifications to fsnotify.
> >>
> >
> > IMO you are going in the right direction, but you have gone a bit too far ;-)
> >
> > My understanding of the requirements and my interpretation of the feedback
> > from filesystem maintainers is that the missing piece in the ecosystem is a
> > user notification that "something went wrong". The "what went wrong" part
> > is something that users and admins have long been able to gather from the
> > kernel log and from filesystem tools (e.g. last error recorded).
> >
> > I do not see the need to duplicate existing functionality in fsmonitor.
> > Don't get me wrong, I understand why it would have been nice for fsmonitor
> > to be able to get all the errors nicely without looking anywhere else, but I
> > don't think it justifies the extra complexity.
>
> Hi Amir,
>
> Thanks for the detailed review.
>
> The reasons for the location record and the ring buffer is the use case
> from Google to do analysis on a series of errors.  I understand this is
> important to them, which is why I expanded a bit on the 'what went
> wrong' and multiple errors.  In addition, The file system specific blob
> attempts to assist online recovery tools with more information, but it
> might make sense to do it in the future, when it is needed.
>
> >> This RFC follows up on my previous proposals which attempted to leverage
> >> watch_queue[1] and fsnotify[2] to provide a mechanism for file systems
> >> to push error notifications to user space.  This proposal starts by, as
> >> suggested by Darrick, limiting the scope of what I'm trying to do to an
> >> interface for administrators to monitor the health of a file system,
> >> instead of a generic inteface for file errors.  Therefore, this doesn't
> >> solve the problem of writeback errors or the need to watch a specific
> >> subsystem.
> >>
> >> * Format
> >>
> >> The feature is implemented on top of fanotify, as a new type of fanotify
> >> mark, FAN_ERROR, which a file system monitoring tool can register to
> >
> > You have a terminology mistake throughout your series.
> > FAN_ERROR is not a type of a mark, it is a type of an event.
> > A mark describes the watched object (i.e. a filesystem, mount, inode).
>
> Right.  I understand the mistake and will fix it around the series.
> >
> >> receive notifications.  A notification is split in three parts, and only
> >> the first is guaranteed to exist for any given error event:
> >>
> >>  - FS generic data: A file system agnostic structure that has a generic
> >>  error code and identifies the filesystem.  Basically, it let's
> >>  userspace know something happen on a monitored filesystem.
> >
> > I think an error seq counter per fs would be a nice addition to generic data.
> > It does not need to be persistent (it could be if filesystem supports it).
>
> Makes sense to me.
>
> >>
> >>  - FS location data: Identifies where in the code the problem
> >>  happened. (This is important for the use case of analysing frequent
> >>  error points that we discussed earlier).
> >>
> >>  - FS specific data: A detailed error report in a filesystem specific
> >>  format that details what the error is.  Ideally, a capable monitoring
> >>  tool can use the information here for error recovery.  For instance,
> >>  xfs can put the xfs_scrub structures here, ext4 can send its error
> >>  reports, etc.  An example of usage is done in the ext4 patch of this
> >>  series.
> >>
> >> More details on the information in each record can be found on the
> >> documentation introduced in patch 15.
> >>
> >> * Using fanotify
> >>
> >> Using fanotify for this kind of thing is slightly tricky because we want
> >> to guarantee delivery in some complicated conditions, for instance, the
> >> file system might want to send an error while holding several locks.
> >>
> >> Instead of working around file system constraints at the file system
> >> level, this proposal tries to make the FAN_ERROR submission safe in
> >> those contexts.  This is done with a new mode in fsnotify that
> >> preallocates the memory at group creation to be used for the
> >> notification submission.
> >>
> >> This new mode in fsnotify introduces a ring buffer to queue
> >> notifications, which eliminates the allocation path in fsnotify.  From
> >> what I saw, the allocation is the only problem in fsnotify for
> >> filesystems to submit errors in constrained situations.
> >>
> >
> > The ring buffer functionality for fsnotify is interesting and it may be
> > useful on its own, but IMO, its too big of a hammer for the problem
> > at hand.
> >
> > The question that you should be asking yourself is what is the
> > expected behavior in case of a flood of filesystem corruption errors.
> > I think it has already been expressed by filesystem maintainers on
> > one your previous postings, that a flood of filesystem corruption
> > errors is often noise and the only interesting information is the
> > first error.
>
> My idea was be to provide an ioctl for the user to resize the ring
> buffer when needed, to make the flood manageable. But I understand your
> main point about the ring buffer.  i'm not sure saving only the first
> notification solves Google's use case of error monitoring and analysis,
> though.  Khazhy, Ted, can you weight in?

I think this is a good point to bring up - a flood of errors shouldn't
drown out other filesystems, and from the perspective of error
reporting, it's better to drop all but one notification from one FS
than to drop the only notification from another. In the cases I can
think of, the first error is probably enough and does simplify things
quite a bit. There is the option of setting up a ring buffer per fs,
which does seem excessive in light of the previous statement.

>
> > For this reason, I think that FS_ERROR could be implemented
> > by attaching an fsnotify_error_info object to an fsnotify_sb_mark:
> >
> > struct fsnotify_sb_mark {
> >         struct fsnotify_mark fsn_mark;
> >         struct fsnotify_error_info info;
> > }
> >
> > Similar to fd sampled errseq, there can be only one error report
> > per sb-group pair (i.e. fsnotify_sb_mark) and the memory needed to store
> > the error report can be allocated at the time of setting the filesystem mark.
> >
> > With this, you will not need the added complexity of the ring buffer
> > and you will not need to limit FAN_ERROR reporting to a group that
> > is only listening for FAN_ERROR, which is an unneeded limitation IMO.
>
> The limitation exists because I was concerned about not breaking the
> semantics of FAN_ACCESS and others, with regards to merged
> notifications.  I believe there should be no other reason why
> notifications of FAN_CLASS_NOTIF can't be sent to the ring buffer too.
> That limitation could be lifted for everything but permission events, I
> think.
>
> --
> Gabriel Krisman Bertazi

--00000000000002194605c2069036
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmAYJKoZIhvcNAQcCoIIPiTCCD4UCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggzyMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
MEvaI7F4ZN2DM20wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADCBmgYIKwYBBQUHAQEE
gY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRsYXNy
M3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2Nh
Y2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvRzV2V
b4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAIKZMQsUIWBTlSa6tHLU5L8W
YVOXfTkEXU6aeq8JjYjcj1fQD+1K0EQhvwz6SB5I0NhqfMLyQBUZHJXChsLGygbCqXbmBF143+sK
xsY5En+KQ03HHHn8pmLHFMAgvO2f8cJyJD3cBi8nMNRia/ZMy2jayQPOiiK34RpcoyXr80KWUZQh
iqPea7dSkHy8G0Vjeo4vj+RQBse+NKpyEzJilDUVpd5x307jeFjYBp2fLWt0UAZ8P2nUeSPjC2fF
kGXeiYWeVPpQCSzowcRluUVFrKApZDZpm3Ly7a5pMVFQ23m2Waaup/DHnJkgxlRQRbcxDhqLKrJj
tATPzBYapBLXne4xggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjACEAH+
DkXtUaeOlUVJH2IZ1xgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOEhOTOx9TyX
8i5gSTN6k7ewAxiX1qUC+kulBYFnjD/4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIxMDUxMTA0NDUyNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCaap1pGo1EuHCLmdSP0lVu01glIFsJ
6tRX99aujJTD/oLLPP4E6rlq9HQbWP2+/TSV/euStndm/tzRH04x4m55ovXonKAN5izvq5DgVKjQ
W4KpMFvrf2RfaHN2+XUKv3NmFYB+Mo5pUcKsiAwS6mnrz43dJzGOcKgsvPH54WaxpgOJoyRiOXWT
4l0MmBKkiWFyfcGJ/k4ULF/La8FlCeqO3dfBOcHbifQ7Lkd6e3vmDaRhaznWlpD9Jmp9YxTa/CeP
i6N2kkNmYsp8TivOkqDwryDg6X/bKpRippYMjmYNfzAjbl7iLQkPiFS7ddCbI+4+AWY+5iKr3aUZ
SAP2BZtu
--00000000000002194605c2069036--
