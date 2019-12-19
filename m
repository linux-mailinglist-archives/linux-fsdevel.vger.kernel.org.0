Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D93126E5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 21:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfLSUFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 15:05:33 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:43243 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfLSUFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:05:33 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MUokB-1iHKGZ3brF-00Qflk; Thu, 19 Dec 2019 21:05:31 +0100
Received: by mail-qv1-f54.google.com with SMTP id x1so2719740qvr.8;
        Thu, 19 Dec 2019 12:05:30 -0800 (PST)
X-Gm-Message-State: APjAAAU0p4byrv7r1t29nrbPdk3EDYRod6/vXXo4fDv114znkPPuzoaH
        aMgrcBnjbQXZ76S/u3LihT/kB+ARYclEDR1vZDU=
X-Google-Smtp-Source: APXvYqw2a1l7eEIr13cHLyNlsGkSNHsp1JQwEETwWf2YAkPJRiT6U8vWTcmVEngBVA+PLBF5rXJPEjsI8UqbgQa0lUc=
X-Received: by 2002:a0c:e7c7:: with SMTP id c7mr9408634qvo.222.1576785929164;
 Thu, 19 Dec 2019 12:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20191217221708.3730997-1-arnd@arndb.de> <20191217221708.3730997-28-arnd@arndb.de>
 <53cd123fdcb893df36e0b3bf9dddbfe08f9c545e.camel@codethink.co.uk>
In-Reply-To: <53cd123fdcb893df36e0b3bf9dddbfe08f9c545e.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Dec 2019 21:05:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Zv4+WUtCNMpNi_TUW2ytCbX6e3KTc2a+0uRiU7aesnQ@mail.gmail.com>
Message-ID: <CAK8P3a3Zv4+WUtCNMpNi_TUW2ytCbX6e3KTc2a+0uRiU7aesnQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/27] Documentation: document ioctl interfaces better
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Vf6A7wnHdwUV1mmBQc//xZwBN4G9rpUAs4Cf4Gurwa8dpNwlzny
 yA5SEKDQ8ARq4LcXLCcAR2Y76nL5f3TZ45mo4Nv0oHAQiTBuj2DpGJwHFlkiEr8MPEU4vLx
 OGpVOMZvPhrFs3h7PUuXLWbmsNxUe5bqcg65a+l0FN6P0EtkVMptMtHfyhH+KbWOxJUF/MI
 3mx3Ul4nOUwn8a/J0+2ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EtSIYLuNofc=:aNaf3WD9WlDBC4TeeToiHz
 INZlLA0W/3aaXz5vfdAESg4qKaeaE/24uCsbyzu9ptJrYZC25l/IEM0M7CI+SSv75dnJREONO
 msIqOP0JJ6SzYnIF9rEB/yD1rWreXDh2B4lryehLhq7ktZuoP6ZC/t0GfM5OSON5/LCh0Fo5/
 S4cdJkq5Lde2COSnOSoc+nfLv7vxYY3GXj5wt6yRx41b52v5UFql8W3D5lp2Aeihs5beVt186
 MKSW91lEPWJAAknHRX5gbDUHLHAaIZvno9mXKyH4cmthspA8zKP18hZ+BG6MAjlJM8eOlNDZd
 C6QO5cjDuIM5Qe3JF9wSbNSwhPTnUilLAGFsHEU1YNAKi74wPdpaBa8hoKk7/opvKtCHinRjV
 hL9hV3aEWqjjOtNhc71qmSNEolRZlHkOVsdCucmOl2kC6ktJev4nB6Z6lW9P1JHU0QDNwvNdW
 0xK03ZgmDNgTk8S2+iKQ9pab5G6Apks6s4zjmnsqwH4ppY9XEQbJjRBgvNvKangVYfiP/vyuf
 WUfJ/9Iyl7JrsVFD35sQDy5DOzIBOW3avRQDzxvvEzDeR57n+SI57KcSUqnv/yu5zEYadlI3x
 Jx+20+QRlhGe9hjd4ztAlJCmi9c6ZpbhrpKF2fcTkWutm8SXzQ3VQv3Ihi5UO0lJ69qTR7pqJ
 RG2mYyPLS4Q+MneyoTqzcAAzOSUJGCI/CZtc/Wg4/CX+SIWSb/PEdzQs9TmxW8Eahf9DG5daT
 H94WbscY5xfyxctzrR4116woLeMi1+lnPk2EU5fd/0qEOIZcpB9naEPzC2+MtAu5lZQ6+uDgS
 tsIPna3XCSisaN/5ra1TAL9uJj0Tt9L7V74SBspfIRPL2xOpzrsx8cNj2g4ywxLP774WRXzyA
 loFRkhfTdchtAWID9RMg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:45 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Tue, 2019-12-17 at 23:17 +0100, Arnd Bergmann wrote:
> > --- /dev/null
> > +++ b/Documentation/core-api/ioctl.rst
> > +``include/uapi/asm-generic/ioctl.h`` provides four macros for defining
> > +ioctl commands that follow modern conventions: ``_IO``, ``_IOR``,
> > +``_IOW``, and ``_IORW``. These should be used for all new commands,
>
> Typo: "_IORW" should be "_IOWR".

Fixed now

> > +with the correct parameters:
> > +
> > +_IO/_IOR/_IOW/_IOWR
> > +   The macro name determines whether the argument is used for passing
> > +   data into kernel (_IOW), from the kernel (_IOR), both (_IOWR) or is
> > +   not a pointer (_IO). It is possible but not recommended to pass an
> > +   integer value instead of a pointer with _IO.
>
> I feel the explanation of _IO here could be confusing.  I think what
> you meant to say was that it is possible, but not recommended, to pass
> integers directly (arg is integer) rather than indirectly (arg is
> pointer to integer).  I suggest the alternate wording:
>
> The macro name specifies how the argument will be used.  It may be a
> pointer to data to be passed into the kernel (_IOW), out of the kernel
> (_IOR), or both (_IOWR).  The argument may also be an integer value
> instead of a pointer (_IO), but this is not recommended.

That's probably better than my version, but I find that misleading as well:
it sounds like _IO() is not recommended, but having no argument with
_IO() is actually fine. This is what I have now:

   The macro name specifies how the argument will be used.  It may be a
   pointer to data to be passed into the kernel (_IOW), out of the kernel
   (_IOR), or both (_IOWR).  _IO can indicate either commands with no
   argument or those passing an integer value instead of a pointer.
   It is recommended to only use _IO for commands without arguments,
   and use pointers for passing data.


> > +data_type
> > +  The name of the data type pointed to by the argument, the command number
> > +  encodes the ``sizeof(data_type)`` value in a 13-bit or 14-bit integer,
> > +  leading to a limit of 8191 bytes for the maximum size of the argument.
> > +  Note: do not pass sizeof(data_type) type into _IOR/IOW, as that will
> > +  lead to encoding sizeof(sizeof(data_type)), i.e. sizeof(size_t).
>
> You left out _IOWR here.  It might also be worth mentioning that _IO
> doesn't have this parameter.

Changed now.

> [...]
> > +Return code
> > +===========
> > +
> > +ioctl commands can return negative error codes as documented in errno(3),
> > +these get turned into errno values in user space.
>
> Use a semi-colon instead of a comma, or change "these" to "which".

done

> > On success, the return
> > +code should be zero. It is also possible but not recommended to return
> > +a positive 'long' value.
> > +
> > +When the ioctl callback is called with an unknown command number, the
> > +handler returns either -ENOTTY or -ENOIOCTLCMD, which also results in
> > +-ENOTTY being returned from the system call. Some subsystems return
> > +-ENOSYS or -EINVAL here for historic reasons, but this is wrong.
> > +
> > +Prior to Linux-5.5, compat_ioctl handlers were required to return
>
> Space instead of hyphen.

done

> > +-ENOIOCTLCMD in order to use the fallback conversion into native
> > +commands. As all subsystems are now responsible for handling compat
> > +mode themselves, this is no longer needed, but it may be important to
> > +consider when backporting bug fixes to older kernels.
> > +
> > +Timestamps
> > +==========
> > +
> > +Traditionally, timestamps and timeout values are passed as ``struct
> > +timespec`` or ``struct timeval``, but these are problematic because of
> > +incompatible definitions of these structures in user space after the
> > +move to 64-bit time_t.
> > +
> > +The __kernel_timespec type can be used instead to be embedded in other
>
> It's not a typedef, so ``struct __kernel_timespec``.

done

> [...]
> > +32-bit compat mode
> > +==================
> > +
> > +In order to support 32-bit user space running on a 64-bit machine, each
> > +subsystem or driver that implements an ioctl callback handler must also
> > +implement the corresponding compat_ioctl handler.
> > +
> > +As long as all the rules for data structures are followed, this is as
> > +easy as setting the .compat_ioctl pointer to a helper function such as
> > +compat_ptr_ioctl() or blkdev_compat_ptr_ioctl().
> > +
> > +compat_ptr()
> > +------------
> > +
> > +On the s/390 architecture, 31-bit user space has ambiguous representations
>
> IBM never used the name "S/390" for the 64-bit mainframe architecture,
> but they have rebranded it several times.  Rather than trying to follow
> what it's called this year, maybe just write "s390" to match what we
> usually call it?

ok, done

> > +
> > +  has four bytes of padding between a and b on x86-64, plus another four
> > +  bytes of padding at the end, but no padding on i386, and it needs a
> > +  compat_ioctl conversion handler to translate between the two formats.
> > +
> > +  To avoid this problem, all structures should have their members
> > +  naturally aligned, or explicit reserved fields added in place of the
> > +  implicit padding.
>
> This should explain how to check that - presumably by running pahole on
> some sensible architecture.

Ok, added "The ``pahole`` tool can be used for checking the alignment.".

> > +* On ARM OABI user space, 16-bit member variables have 32-bit
> > +  alignment, making them incompatible with modern EABI kernels.
>
> I thought that OABI required structures as a whole to have alignment of
> 4, not individual members?  Which obviously does affect small
> structures as members of other structures.

You are right, I clearly misunderstood that. Changed the paragraph now to

* On ARM OABI user space, structures are padded to multiples of 32-bit,
  making some structs incompatible with modern EABI kernels if they
  do not end on a 32-bit boundary.

* On the m68k architecture, struct members are not guaranteed to have an
  alignment greater than 16-bit, which is a problem when relying on
  implicit padding.

> [...]
> > +Information leaks
> > +=================
> > +
> > +Uninitialized data must not be copied back to user space, as this can
> > +cause an information leak, which can be used to defeat kernel address
> > +space layout randomization (KASLR), helping in an attack.
> > +
> > +As explained for the compat mode, it is best to not avoid any implicit
>
> Delete "not".

Done.

 > +padding in data structures, but if there is already padding in existing
> > +structures, the kernel driver must be careful to zero out the padding
> > +using memset() or similar before copying it to user space.
>
> This sentence is rather too long.  Also it can be read as suggesting
> that one should somehow identify and memset() the padding just before
> copying to user-space.  I suggest an alternate wording:
>
> For this reason (and for compat support) it is best to avoid any
> implicit padding in data structures.  Where there is implicit padding
> in an existing structure, kernel drivers must be careful to fully
> initialize an instance of the structure before copying it to user
> space.  This is usually done by calling memset() before assigning to
> individual members.

Sounds good, I've taken that paragraph now.

> [...]
> > +Alternatives to ioctl
> > +=====================
> [...]
> > +* A custom file system can provide extra flexibility with a simple
> > +  user interface but add a lot of complexity to the implementation.
>
> Typo: "add" should be "adds".

Fixed

Thanks for all the good suggestions!

      Arnd
