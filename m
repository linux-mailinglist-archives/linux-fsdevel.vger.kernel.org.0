Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8881260B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 12:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLSLUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 06:20:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38725 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfLSLUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:20:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id d7so2438985otf.5;
        Thu, 19 Dec 2019 03:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q86lzAwYlZJOZFsQXI59MTkZWLAWnklcw1QSoLucOeY=;
        b=T5FBaj0wqy+SDbVZd8ND4FLNPYoKNJ2rFQ5QDaeV7hhQUgVfavoJdwSHnu9XGmGojv
         NpUUHHOHH/O3r6Cz7oQXQ54VfgX1WnY1FaDbi0bwZTyoAeXOKawFByhVnABBdrOb3W51
         apyHLw57/kbptO/jqi83ZZ0ALrjiFitzem5MgMjmSb+8ysaIki4/icFmhXeWcnQ3+17f
         BgXbB2mat7BsXAjQgcqS76HJwguKQHm3LQ04iCt2Rwg1eG6AO7i8aEMwtfsC2Mtdl/vu
         TuF+lU+bBcYZ3UW3+5emiF3CukuX3wGj0AuboTIQsB1sqOmPkLOLQm704o/9p4uuJdMK
         KXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q86lzAwYlZJOZFsQXI59MTkZWLAWnklcw1QSoLucOeY=;
        b=H8ff3wmXd/W7CCqS9BvAu8Cq+9Fu6YemkWMrPzBRCJySFuIWXnSPs00ogW4gKamHSj
         HyPCS7WFG/FOBAoChsX6B0KPZIBvc5Me3fnEPZ3xafcWedVY4gmfcbaSak9liA6Uk2NO
         oKtVQi3Qr7N92A8wm6Pp60KRYjU99xubRjRq+hl27H1ibzxngrAYvNtf8t4tohI83u+g
         n1AqgbC/KFdvJ00r9Fuy6zWoyLg7ttR0umZykPUcuBoI4hNyg/9oFlZxrFCV+4/b1e8E
         l7+Eos4lNZ6zZQTKi+7aUj1Y8O1gbaYa7A7c76C3zmLXHmuZLZ9OzUjV2sPCJGAb/d/b
         5W4A==
X-Gm-Message-State: APjAAAXrFtIHOg7xG2hstQm9VdYyp/mMKtesXFmKM6qrE3l/wK0AFYg5
        jlXTNORnaHlym5nmqJ13fQ0DKH1C4EyiBJN1Tlc=
X-Google-Smtp-Source: APXvYqywsQSCFq193tXJowtm7MgAXzeCgVZaTneF+QFvWsd6/7L+2PrwC8RZGp9Sjc0hNFrAOo6xigDwW3Yu24jOjb8=
X-Received: by 2002:a05:6830:145:: with SMTP id j5mr7883934otp.242.1576754447447;
 Thu, 19 Dec 2019 03:20:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Thu, 19 Dec 2019 03:20:46 -0800 (PST)
In-Reply-To: <c0d9eed8-4cb6-54a5-95a0-a18aec8b70ee@redhat.com>
References: <20191213055028.5574-2-namjae.jeon@samsung.com>
 <CGME20191216135033epcas5p3f2ec096506b1a48535ce0796fef23b9e@epcas5p3.samsung.com>
 <088a50ad-dc67-4ff6-624d-a1ac2008b420@web.de> <002401d5b46d$543f7ee0$fcbe7ca0$@samsung.com>
 <c6698d0c-d909-c9dc-5608-0b986d63a471@metux.net> <000701d5b537$5b196f80$114c4e80$@samsung.com>
 <c0d9eed8-4cb6-54a5-95a0-a18aec8b70ee@redhat.com>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Thu, 19 Dec 2019 20:20:46 +0900
Message-ID: <CAKYAXd84p=rB6kF5RvXs2QvxmRYX280Mio8sPbDgJKiE6Eqo9w@mail.gmail.com>
Subject: Re: [PATCH v7 01/13] exfat: add in-memory and on-disk structures and headers
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     =?UTF-8?B?7KCE64Ko7J6sL1MvVyBQbGF0Zm9ybSBMYWIoVkQpL1N0YWZmIEVuZ2luZWVyL+yCvOyEseyghA==?=
         =?UTF-8?B?7J6Q?= <namjae.jeon@samsung.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2019-12-18 18:33 GMT+09:00, Maurizio Lombardi <mlombard@redhat.com>:
> Hello,
>
> Dne 18.12.2019 v 01:09 =EC=A0=84=EB=82=A8=EC=9E=AC/S/W Platform Lab(VD)/S=
taff Engineer/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90
> napsal(a):
>> Well, I think that there is currently no proper mkfs(format), fsck(repai=
r)
>> tool for linux-exfat.
>> I am working on it and will announce it here as soon as possible.
>
> Are you aware that on Debian and Fedora/RHEL distros a package named
> exfat-utils is available?
> It provides an mkfs and fsck implementation for exfat filesystems.
>
> You can find the source code here: https://github.com/relan/exfat
Yes, I know. They are part of fuse-exfat. I want to create an official tool
for exfat in linux kernel.
And fsck implementation in fuse-exfat is early development stage yet. In
addition, This project seems to have stopped development.

Thanks!
>
> Maurizio
>
>
