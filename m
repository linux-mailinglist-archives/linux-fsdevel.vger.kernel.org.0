Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D90DEB0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfJULhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 07:37:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41102 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727832AbfJULhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571657841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vofe0VQns1D/DiFjEtpjmLVshKuMJelezuNzu5bHnE0=;
        b=WnTjY92ErqFIr/sqcaFnPpe4V9InbgdELKqLcR4Hq9xImm2c7UFOIiphi+iOMAr/f9hc66
        MoG4ne63mGDjiukCW6B0OLGRlry32BTsIprogAvnfxzQE+mLCInpjEbWWhrkwNvhM57+Ew
        TLglelxvtimqhGsovNHG7AbUP6rY08E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-9eKivh9JPFea858DYC3R4g-1; Mon, 21 Oct 2019 07:37:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B3F2107AD31;
        Mon, 21 Oct 2019 11:37:16 +0000 (UTC)
Received: from [10.40.204.224] (ovpn-204-224.brq.redhat.com [10.40.204.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AB7D5D6A5;
        Mon, 21 Oct 2019 11:37:14 +0000 (UTC)
Subject: Re: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon
 Software.
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
References: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
 <20191021111136.adpxjxmmz4p2vud2@pali>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Maurizio Lombardi <mlombard@redhat.com>
Message-ID: <a4c42aa5-f9b7-4e74-2c11-220d45cb3669@redhat.com>
Date:   Mon, 21 Oct 2019 13:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20191021111136.adpxjxmmz4p2vud2@pali>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 9eKivh9JPFea858DYC3R4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Dne 21.10.2019 v 13:11 Pali Roh=C3=A1r napsal(a):
> Are you going to add support also for TexFAT? Or at least for more two
> FAT tables (like is used in FAT32)?
>=20

Just a small note here, differences between FAT and exFAT:

1) Contiguous files get a special treatment by exFAT: they do not use the F=
AT cluster chain.
2) exFAT doesn't use the FAT to track free space, it uses a bitmap.

So, 2 FAT tables are probably not sufficient for recovery, 2 bitmaps are ne=
eded too.[1]
Btw, only Windows CE supported this.

[1] http://www.ntfs.com/exfat-allocation-bitmap.htm

Maurizio

