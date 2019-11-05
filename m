Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD50BF01C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 16:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbfKEPoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 10:44:10 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35480 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbfKEPoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:44:10 -0500
Received: by mail-yw1-f66.google.com with SMTP id r131so1874312ywh.2;
        Tue, 05 Nov 2019 07:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=08WVEbhNhtnwwFfAggXo5kHnsDkJykTkYyyFy8JZdPk=;
        b=uIt8lSknzzVMvqUotzhN/2/WopvdWeA5IQfm9S53iFkNWcWJNIcvmftiX32B7RSPxC
         K5Y9vAPYmjQWwYPyBKUu8U6aokIYM89zGaKi2UztGP+VFJCmWuRvltnddqfeY7nDLndg
         l+2VnlKee0opYVWlyTXwDu+kBU9TVH3bcJGlqR2rzaQm69fOlQi4cyhpfcbMoLViLQGQ
         G+4fJTE4w/jVn9PpNYxnYDescFRjMB0ni0X1N5IPZOv+gdfkTOTRHTdTAIzX9xqmX6kL
         AN5oxZwsP+D3d8uaoCP5qEQQmOyy6qa9CbkSNYPkkI7Hz2DUwI37Eq2aO4uepMdfAVmk
         Vwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=08WVEbhNhtnwwFfAggXo5kHnsDkJykTkYyyFy8JZdPk=;
        b=d+Me0PV8exnUJw4BjjDrrYaS3F+/SSu5CpgOazSwm9uJOkodGjWpI+01AKUJYWcpI1
         7CFVUgmMkANWxSh7h0edKDxCypdrmB0i+nSC0KjXdxdiCp2A30GCXaV8K3eEvzRbbUHT
         g3woOKxb5nZs4KCeqRHpJVdX+orc5aRtSl+zlJEWsWaiiFXnfPFow5GrO7xyNq1KtLnr
         Iy9jidhPY0i8sxYS80POIw1Ytz63zlh7FIyNIJgVsJw6zI4Tp4fjW18bjw8O3/+n9xzk
         JHPoR0fbx5TikNV7Ffw8U2FBZTO8v3r+DKv/Ll5/I63NbcHV97yJFVmajOuRndr37DDu
         vAkQ==
X-Gm-Message-State: APjAAAUomorjkI2rCnbZKxhte8E8h0rJtyBD+U6QHRk5H9vc56B+a37M
        cvIB+5Hk21l9mLzQ+0CVGNEoYy+Ry88=
X-Google-Smtp-Source: APXvYqx+cJfy0zWrq4IIG9j90Og8qMN89GL+BvQ7qRX6dgP+VSFXrDPVIvtJZxdA64w2CRFhall4fA==
X-Received: by 2002:a81:484d:: with SMTP id v74mr25233492ywa.448.1572968649266;
        Tue, 05 Nov 2019 07:44:09 -0800 (PST)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l207sm13998897ywl.20.2019.11.05.07.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:44:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 00/35] user xattr support (RFC8276)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20191104225846.GA13469@fieldses.org>
Date:   Tue, 5 Nov 2019 10:44:06 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1661F81-0232-4A35-B6BD-5857BF2D65A3@gmail.com>
References: <cover.1568309119.git.fllinden@amazon.com>
 <9CAEB69A-A92C-47D8-9871-BA6EA83E1881@gmail.com>
 <20191024231547.GA16466@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <18D2845F-27FF-4EDF-AB8A-E6051FA03DF0@gmail.com>
 <20191104030132.GD26578@fieldses.org>
 <358420D8-596E-4D3B-A01C-DACB101F0017@gmail.com>
 <20191104162147.GA31399@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20191104225846.GA13469@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>,
        Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 4, 2019, at 5:58 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Mon, Nov 04, 2019 at 04:21:47PM +0000, Frank van der Linden wrote:
>> On Mon, Nov 04, 2019 at 10:36:03AM -0500, Chuck Lever wrote:
>>>=20
>>> Following the server's local file systems' mount options seems like =
a
>>> good way to go. In particular, is there a need to expose user xattrs
>>> on the server host, but prevent NFS clients' access to them? I can't
>>> think of one.
>>=20
>> Ok, that sounds fine to me - I'll remove the user_xattr export flag,
>> and we had already agreed to do away with the CONFIGs.
>>=20
>> That leaves one last item with regard to enabling support: the client =
side
>> mount option. I assume the [no]user_xattr option should work the same =
as
>> with other filesystems. What about the default setting?
>=20
> Just checking code for other filesystems quickly; if I understand =
right:
>=20
> 	- ext4 has user_xattr and nouser_xattr options, but you get a
> 	  deprecation warning if you try to use the latter;
> 	- xfs doesn't support either option;
> 	- cifs supports both, with xattr support the default.
>=20
> Not necessarily my call, but just for simplicity's sake, I'd probably
> leave out the option and see if anybody complains.

Agree, I would leave it out to begin with. Anyone on linux-fsdevel,
feel free to chime in here about why some other file systems have
this mount option. History lessons welcome.


>> Also, currently, my code does not fail the mount operation if user =
xattrs
>> are asked for, but the server does not support them. It just doesn't
>> set NFS_CAP_XATTR for the server, and the xattr handler entry points
>> eturn -EOPNOTSUPP, as they check for NFS_CAP_XATTR. What's the =
preferred
>> behavior there?
>=20
> getxattr(2) under ERRORS says:
>=20
> 	ENOTSUP
> 	      Extended attributes are not supported by the filesystem,
> 	      or  are disabled.
>=20
> so I'm guessing just erroring out is clearest.

IMO on the client, we want getxattr failure behavior to be consistent =
among:

- A version of NFS that does not support xattrs at all (say, v3)

- A version of NFS that can support them but doesn't (say, NFSv4.2 =
before these patches)

- A version of NFS that can support them, but the server doesn't

- A version of NFS that can support them, a server that can support =
them, but it's filesystem doesn't


> I also see there's an EOPNOTSUPP return in the nouser_xattr case in
> ext4_xattr_user_get.  (errno(3) says ENOTSUP and EOPNOTSUPP are the =
same
> value on Linux.)
>=20
> --b.

--
Chuck Lever
chucklever@gmail.com



