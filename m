Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D885A88C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfIDOZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 10:25:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34190 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbfIDOZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:25:32 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so44654350ioa.1;
        Wed, 04 Sep 2019 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J14Deb8/u/x8SPSlK7MOeAWJqG+LQLoxFq5bvKEaz7c=;
        b=iz5ubyrro5kU3CaILVKZ8g/Z46nRZl2E5EyMh/ddWuMOVV58AfTdZwE1lRlA+/2gC6
         rrkQv7Bp6R8klnOdkZovLFlAMseafse6HjXYkwlivbDXKrdmit02Xak1fqWHxonDgVV6
         /THpyJ3YfT/ZPmf9TwGbUj9Eofn+9rujJFBRsMPhzq3z2WxmMmeYhvn/qFEMkL9hX6PM
         alZD7vxlRLJJ214HETUdqMiNsuZef2T6xZqoD1niihB8KCuW/RE9kZJaw5pTU06Z4Fti
         x+5IUyhPNbOkcSzgA9xXTC6aAbu+aIpcrugIKDZjoO8KL0P98vOCMjXx4rCJXes0SPCZ
         AweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J14Deb8/u/x8SPSlK7MOeAWJqG+LQLoxFq5bvKEaz7c=;
        b=kPaXiqTwfNtaB3lF0XPQW2rDdFSjGyMy6n03RnTEpJg39F9AnBfGTNt96ZSspWiEvn
         NLkIotSqaRY4h5M6PsuiCSU450kzbTJfrWhlLsuqicIAc0NFRy0EhjoGnxzMeiN8eNf1
         zED88leKCoTQDde0Imzy8xcOpqZX9xpMaSelfPbrATnX1VAP/T/AwjZmBmhHMVJg/HYx
         FwNj7HQYX6FoZxUWFC8yWkXC7Zg1OYlJ9f+llQUTu1glBiMKdVl7dMdgcLMx7byep3fC
         At8nlWE2cnZ5RpMMXT2Y7RDKDc6n4TJDPi3EVFct3hE9DDAK1BRUUsthV4VqQ0CC/eYp
         3Eng==
X-Gm-Message-State: APjAAAVny7GYfe0SBVUOf7saYsc8x/Cq1HwIa7SnRGkp+cbUzc0HQ80L
        S23FZdrxpcT7wMIMr4Xy4jO5E8Qj1N31PUeLlu8mkd87
X-Google-Smtp-Source: APXvYqzeRG/uyzgFU9gsbGJOxvokb0v5sAg3EY0xn/Cbi7tu5fxDRkc9byd7neezSHJcWUe85BzUNRQz0zOhbAy7Xpo=
X-Received: by 2002:a6b:148b:: with SMTP id 133mr5849872iou.81.1567607130936;
 Wed, 04 Sep 2019 07:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <1567523922.5576.57.camel@lca.pw> <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <20190903211747.GD2899@mit.edu> <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
 <CAK8P3a0AcPzuGeNFMW=ymO0wH_cmgnynLGYXGjqyrQb65o6aOw@mail.gmail.com>
 <CABeXuvq0_YsyuFY509XmwFsX6tX5EVHmWGuzHnSyOEX=9X6TFg@mail.gmail.com> <20190904125834.GA3044@mit.edu>
In-Reply-To: <20190904125834.GA3044@mit.edu>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 4 Sep 2019 07:25:19 -0700
Message-ID: <CABeXuvoKE4VrnAcHff+veyds+JbqzrUtYxBJ4tUv3eaUsec0bw@mail.gmail.com>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qian Cai <cai@lca.pw>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Sep 4, 2019, at 5:58 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
>> On Tue, Sep 03, 2019 at 09:50:09PM -0700, Deepa Dinamani wrote:
>> If we don't care to warn about the timestamps that are clamped in
>> memory, maybe we could just warn when they are being written out.
>> Would something like this be more acceptable? I would also remove the
>> warning in ext4.h. I think we don't have to check if the inode is 128
>> bytes here (Please correct me if I am wrong). If this looks ok, I can
>> post this.
>
> That's better, but it's going to be misleading in many cases.  The
> inode's extra size field is 16 or larger, there will be enough space
> for the timestamps, so talking about "timestamps on this inode beyond
> 2038" when ext4 is unable to expand it from say, 24 to 32, won't be
> true.  Certain certain features won't be available, yes --- such as
> project-id-based quotas, since there won't be room to store the
> project ID.  However, it's not going to impact the ability to store
> timestamps beyond 2038.  The i_extra_isize field is not just about
> timestamps!

I understand that i_extra_isize is not just about timestamps. It=E2=80=99s
evident from EXT4_FITS_IN_INODE(). I think we can check for
EXT4_FITS_IN_INODE() here if that will consistently eliminates false
positives.

But, I hear you. You think this warning is unnecessary. I think there
are many file systems and I don=E2=80=99t think anybody would knows in=E2=
=80=99s and
outs of each one. I think if I=E2=80=99m mounting an ext4 fs and it has mix=
ed
sizes of inodes, I think I would at least expect a dmesg(with a hint
on how to fix it) considering that this filesystem is restricted in
more ways than just time. Is this the purpose of the warning you
already have?:

        if (error && (mnt_count !=3D le16_to_cpu(sbi->s_es->s_mnt_count))) =
{
               ext4_warning(inode->i_sb, "Unable to expand inode %lu.
Delete some EAs or run e2fsck.",

Maybe there should be a warning, but it has nothing to do with just
time. Do we already have this?

-Deepa
