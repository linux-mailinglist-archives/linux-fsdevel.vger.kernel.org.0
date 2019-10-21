Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AECDEA68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfJULIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 07:08:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59565 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728348AbfJULIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571656094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/m6iR+lAGe4oWRdWBbbxaVLhAtZ0rF+yJWWCBo2VUQY=;
        b=AR0Ji90MP+RQX7cImW5E3LCqQ5Bg8ureKOZxD0zlIzqnldlCw5c27JiXuwk9pOiv7m9UV9
        Jy7VPk3MME1to/9um/o6kSVfbpHqKuiVNx18gsY87dQHzSnFok9ilh4Ow8ngjzDAhunRX6
        QtZFlGIEWVSe4LItrpbHpGH1OQGcYC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-66Y5VWh_OvypLh4oG7bHRg-1; Mon, 21 Oct 2019 07:08:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C925107AD31;
        Mon, 21 Oct 2019 11:08:10 +0000 (UTC)
Received: from [10.40.204.224] (ovpn-204-224.brq.redhat.com [10.40.204.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48E3E5D6A5;
        Mon, 21 Oct 2019 11:08:08 +0000 (UTC)
Subject: Re: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon
 Software.
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Richard Weinberger <richard.weinberger@gmail.com>
References: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
 <CAFLxGvyFBGiDab4wxWidjRyDgWkHVfigVsHiRDB4swpB3G+hvQ@mail.gmail.com>
 <20191021105409.32okvzbslxmcjdze@pali>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Maurizio Lombardi <mlombard@redhat.com>
Message-ID: <0877502e-8369-9cfd-36e8-5a4798260cd4@redhat.com>
Date:   Mon, 21 Oct 2019 13:08:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20191021105409.32okvzbslxmcjdze@pali>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 66Y5VWh_OvypLh4oG7bHRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Dne 21.10.2019 v 12:54 Pali Roh=C3=A1r napsal(a):
> Plus there is new version of
> this out-of-tree Samsung's exfat driver called sdfat which can be found
> in some Android phones.=20

[...]

>=20
> About that one implementation from Samsung, which was recently merged
> into staging tree, more people wrote that code is in horrible state and
> probably it should not have been merged. That implementation has
> all-one-one driver FAT12, FAT16, FAT32 and exFAT which basically
> duplicate current kernel fs/fat code.
>=20
> Quick look at this Konstantin's patch, it looks like that code is not in
> such bad state as staging one. It has only exFAT support (no FAT32) but
> there is no write support (yet).

But, AFAIK, Samsung is preparing a patch that will replace the current
staging driver with their newer sdfat driver that also has write support.

https://marc.info/?l=3Dlinux-fsdevel&m=3D156985252507812&w=3D2

Maurizio

