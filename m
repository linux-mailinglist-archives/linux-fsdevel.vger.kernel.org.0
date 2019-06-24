Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F2B50054
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 05:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfFXDpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jun 2019 23:45:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43786 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfFXDpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:45:05 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so537522ios.10;
        Sun, 23 Jun 2019 20:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcJh3ScCQqVkMPXMTs4j568BRTTMVAoHQlqsGJwztRo=;
        b=KKTTqkx4JnK2agWr7E9o07V5mvQMzoCeoQi8WxAGc0DWXD7dwQdOsIuYg/RZK5TiLk
         GZ4CBGZq7BBvYJ8FEVIvznQ8OxzXxItHmhfPtdXSfBNmvoKkf/PSexyamiKY8hK8MXDs
         OJ1hxfHxHBmoeLG974AT8Xumkmbqpqj7FoHn/9mCNLETspV+qUEzmvU0UbIwVeIUA+9A
         Vk99ymB3crRWzCT6ESfrGMd9WFs53W/rQwHvw33bZ6JDKHrN4VHdxMIZ2ogGgK7l4Sx9
         UtkD3EsnvEdCpDwddPUcXUWwZroYFQGGUPLsGoKlKG2w4T3li7fLS2LHOA9nW+Cn/yYJ
         i4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcJh3ScCQqVkMPXMTs4j568BRTTMVAoHQlqsGJwztRo=;
        b=FtsJMNdPTR6Sw0BZrqMn5UxCrvz9tcGsnS+BwlCVTSaPN4LsNIJkpGB6cmaM4eTuUy
         KVBWk1y+4g2PLemg/dd4RMb1sucmQLMYmW00m8JmRqyHqzhSHTtGoKZNM6z8+PM/fiOc
         mngX8sgyX93nxYn0KO+N4JSHPjC5gOEOxeXkg83DM1dx59n1ADx+fYL1Ah2LzLZd6FHU
         gNt9KwosDluMNwP7epNRdcXeS5qkPncBwjWoEIbHOfHBIANPBI6ZegPoGLRb+DSLGf4Q
         hMXuPvSxK/UDTSjdYeh4iaIrHTjpWBg9PCoRYc6AgDcDkCv2TbW1sIesBtllA5yCohGU
         TRjA==
X-Gm-Message-State: APjAAAV7c4Ak0ZzV3lYznDVNlXFR2SPz2+3a7aqxqLTksUPWUs8IhDby
        jImUF+fHkR8sSPEL7h4ZjyVbeQAZ+oshUIciulGL9w==
X-Google-Smtp-Source: APXvYqxd3DUikZw6ws4oXLhCbFlSHQk7m77ZT3mQh5+OUqZfuJ06Pw2qTK8TafoHCEK2iDQLz4IATsddwzxZqEO8LAk=
X-Received: by 2002:a6b:3883:: with SMTP id f125mr108394436ioa.109.1561347904242;
 Sun, 23 Jun 2019 20:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mv+oqGxZRkV_ROqdauNW0CYJ7X9uJCk+uYmercJ4De41w@mail.gmail.com>
In-Reply-To: <CAH2r5mv+oqGxZRkV_ROqdauNW0CYJ7X9uJCk+uYmercJ4De41w@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Mon, 24 Jun 2019 13:44:53 +1000
Message-ID: <CAN05THTqP+_uSEPq2FqBEnV8FeuutaHASznH6iBDS=C0hCD=kQ@mail.gmail.com>
Subject: Re: xfstest 531 and unlink of open file
To:     Steve French <smfrench@gmail.com>
Cc:     samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 1:23 PM Steve French <smfrench@gmail.com> wrote:
>
> Xioli created a fairly simple unlink test failure reproducer loosely
> related to xfstest 531 (see
> https://bugzilla.kernel.org/show_bug.cgi?id=203271) which unlinks an
> open file then tries to create a file with the same name before
> closing the first file (which fails over SMB3/SMB3.11 mounts with
> STATUS_DELETE_PENDING).
>
> Presumably we could work around this by a "silly-rename" trick.
> During delete we set delete on close for the file, then close it but
> presumably we could check first if the file is open by another local
> process and if so try to rename it?
>
> Ideas?

The test is to check "can you unlink and recreate a file while someone
(else) is holding it open?"

I don't think you can rename() a file while other folks have it open :-(
This is likely a place where NTFS is too different from Posix that we
can't get full 100% posix semantics.

>
> --
> Thanks,
>
> Steve
