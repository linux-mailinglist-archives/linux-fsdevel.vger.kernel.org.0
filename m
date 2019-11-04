Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43743EE3F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 16:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfKDPgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 10:36:06 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41623 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfKDPgG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:36:06 -0500
Received: by mail-yw1-f65.google.com with SMTP id j190so1313759ywf.8;
        Mon, 04 Nov 2019 07:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pLOPRhpmXjrgwcqIYfzopv6uLk2kDJFpocTgKt/ho7A=;
        b=qaZHAby0y6x92nJLzV8VZz6JA8pAo4aAszvY3kwJ0vgHy9D+YJ6XJSqh+ycJancvuz
         bd1PiNES3AaA4WhF8k6+u0PQwA8WQt6DHnI9+7zxcZNmnTWnrLh2GEss6QArMo07wHz+
         j5n3Yc2Bmw6pmz7hJJZqSI5y6C3WyVl3o4ZoeQvMHt4V8pnm1A/KDnDj+sm8Vg94yv1b
         MGjtSHTX1bQM8SU0a55WZcKHtKNdEIMsYVfOMb2/A+F9xXrzf6O7xLv9K7oVOuNb0eTg
         52NJHzer5J4XRjUdF7RBfZs9go8eyuKsk46074vDxANNOIO5JLRSn4g5+idxuKo4WJSx
         hhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pLOPRhpmXjrgwcqIYfzopv6uLk2kDJFpocTgKt/ho7A=;
        b=jISeTuGxaBgSV/lHDH/j3mkO3Pr0v7BVWDT/rNRl7HrNgvQRXYc8LedJIf5KBgqmZh
         jJQejl3qlDXC6Hr41qR1+ISDHAjBhrOFnxGxkIuwiKsKXpSv8ovXoBuqlU9d82EuRreI
         0KmLQYrPkMfpOtypq45Vq4ZtgQrnR+8SRFcdRYovtgXNt7NUZ1Ranj9w8Y9RcxTVA0ra
         oupDIv2eQgtxaY/Q9kpqijqhcP7agSHtR0iKeel9vmWToIqauj+CbDUHUBX3wwBVcW23
         5VcbEhQNNR+YFFUDLofASN5ceDsB/oug+2C/72YJ+KN7/c/YjGgn5OS0mzOG1FbCAmAK
         OEXQ==
X-Gm-Message-State: APjAAAX23zthrktr9wA+ekpfzd2Hr8P9qCXkwHwpPDpk6gHELiriNYdI
        hMrHFpDOIbuT5eIbxKP2ytMPRMw+rE0=
X-Google-Smtp-Source: APXvYqz8CiOYvECxJkYLAullstmrcCAWveFe0OubmNejMFyQMkiI2hVSvRbJ0w7YnERvCD0F2pCyVw==
X-Received: by 2002:a81:6589:: with SMTP id z131mr8807266ywb.299.1572881765559;
        Mon, 04 Nov 2019 07:36:05 -0800 (PST)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y204sm4005867ywg.67.2019.11.04.07.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 07:36:04 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 00/35] user xattr support (RFC8276)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20191104030132.GD26578@fieldses.org>
Date:   Mon, 4 Nov 2019 10:36:03 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <358420D8-596E-4D3B-A01C-DACB101F0017@gmail.com>
References: <cover.1568309119.git.fllinden@amazon.com>
 <9CAEB69A-A92C-47D8-9871-BA6EA83E1881@gmail.com>
 <20191024231547.GA16466@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <18D2845F-27FF-4EDF-AB8A-E6051FA03DF0@gmail.com>
 <20191104030132.GD26578@fieldses.org>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 3, 2019, at 10:01 PM, bfields@fieldses.org wrote:
>=20
> On Fri, Oct 25, 2019 at 03:55:09PM -0400, Chuck Lever wrote:
>>> On Oct 24, 2019, at 7:15 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>>> I think both of these are cases of being careful. E.g. don't enable
>>> something by default and allow it to be disabled at runtime in
>>> case something goes terribly wrong.
>>>=20
>>> I didn't have any other reasons, really. I'm happy do to away with
>>> the CONFIG options if that's the consensus, as well as the
>>> nouser_xattr export option.
>>=20
>> I have similar patches adding support for access to a couple of
>> security xattrs. I initially wrapped the new code with CONFIG
>> but after some discussion it was decided there was really no
>> need to be so cautious.
>>=20
>> The user_xattr export option is a separate matter, but again,
>> if we don't know of a use case for it, I would leave it out for
>> the moment.
>=20
> Agreed.
>=20
> Do ext4, xfs, etc. have an option to turn off xattrs?  If so, maybe it
> would be good enough to turn off xattrs on the exported filesystem
> rather than on the export.

Following the server's local file systems' mount options seems like a
good way to go. In particular, is there a need to expose user xattrs
on the server host, but prevent NFS clients' access to them? I can't
think of one.


> If not, maybe that's a sign that hasn't been a need.
>=20
> --b.

--
Chuck Lever
chucklever@gmail.com



