Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25746DEB87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 14:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfJUMDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 08:03:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22145 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727962AbfJUMDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571659389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmgPAC7W/5410XjvqZWnihFBmhF2Kg+1698CXHy3Bl0=;
        b=SzoCuxeRPztIGTJVYfDPlHDEZAiXK0ELCM+Nkhu8sxf6OoGVWx2dIrOYAIyCnSfyqSA2iU
        R0KnDkxhCWBUNmp4IDas7CF8JTVBkytNcgdRpgxlMCibneghL8SuNYQkxiTJ45IqplQrwG
        w6sjrxil5mRFlQIgAiiGRNAW3ogSgWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-oxBS3Ss1NUKGY8SDNye1Wg-1; Mon, 21 Oct 2019 08:01:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 033BC100550E;
        Mon, 21 Oct 2019 12:01:13 +0000 (UTC)
Received: from [10.40.204.224] (ovpn-204-224.brq.redhat.com [10.40.204.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDE7B167A3;
        Mon, 21 Oct 2019 12:01:10 +0000 (UTC)
Subject: Re: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon
 Software.
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
References: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
 <20191021111136.adpxjxmmz4p2vud2@pali>
 <a4c42aa5-f9b7-4e74-2c11-220d45cb3669@redhat.com>
 <20191021114556.lk2zkha57xmav7xz@pali>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   Maurizio Lombardi <mlombard@redhat.com>
Message-ID: <bcc406b7-d8ed-475d-d5d7-16b97ec40022@redhat.com>
Date:   Mon, 21 Oct 2019 14:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20191021114556.lk2zkha57xmav7xz@pali>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: oxBS3Ss1NUKGY8SDNye1Wg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Dne 21.10.2019 v 13:45 Pali Roh=C3=A1r napsal(a):
> They are represented by one member
> in boot sector structure).
>=20
>> Btw, only Windows CE supported this.
>=20
> Is this information based on some real tests? Or just from marketing or
> Microsoft's information? (I would really like to know definite answer in
> this area).

I admit I have read it on Microsoft's exFAT documentation, unfortunately
I don't have a WinCE device to test if it's really true.


Maurizio

