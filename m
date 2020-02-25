Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5DA16BACF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 08:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgBYHif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 02:38:35 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:34227 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgBYHif (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:38:35 -0500
Received: by mail-pj1-f44.google.com with SMTP id f2so776152pjq.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2020 23:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=sHG4uuM2vxe7dCkVlpWWFTJfDKsCAqj455lSgU/Lri8=;
        b=fEj5QzAh2o/tqGn4PKWI/WWgd5icFMtGvarE1t9sfeNQijPcDI3UtvJqVAcQkrn+r7
         C9nmsQOxUhRNybFljE1ePBcrLqocDbi5COOx+B/gEHFY5Xl196yffP7IP57mrNZkq3/W
         aafYuGAERctpxik7RiupkP2dWkfwnHUqBePH3hmwIta3vij7W2WpBP4W2GvG4uzw/TdJ
         hM5OwStvQNwci0Yb6SGE1hbwjAqu3c/2jfkZh00aBZYCyytmMqkZfyaZV2OnSjabrb23
         hoMdnVAID88C99zXcstGn4umKO6VuUU5YIRqNFb6Q/LyTDhi2WW/8wrM3X8nLsS5+EqC
         8uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=sHG4uuM2vxe7dCkVlpWWFTJfDKsCAqj455lSgU/Lri8=;
        b=tTkMYsPy0EX0/AtRToKuxXlSgZ2Lcy+3xnOr8NKODUDfDjT7qpzog3afaGFnHzSdVk
         DA069lFXYDCOErWRbQJAPqzPXv9e0mUYeAqnCI4zu4z/jgVswfQDE4nHS7k6je1OwjiZ
         OnDWtGw4anOI48TrWYRr2wx1Yjm1cLRwPhmLf4y5b6UV14RFE6BEy2E0UJjMxCUFxPAt
         q41k9Y/k+aunx8Ctq1GDsYEa83a7ZE6v37kdP93GgribvrroFi8tFZMNIOF27onOz0EO
         xTemfr3PPtMAvkEplWdlZhMTdl8bRGOlMkm9cQ+jaP+L2YyaInlfXnIxmPIV3ALVMNgU
         jxEA==
X-Gm-Message-State: APjAAAWKl/F18i+Faij4Jqs5qIRhFNcj7mXcbNQHHies1u6wgK1K2TlG
        FudXX6IOyQ1hryka6EkQZZ2xQr2+oN84uw==
X-Google-Smtp-Source: APXvYqwsbHW6YQG+vrm3AFaNK2Uk1Bn90NSKZ+uweYDrf6sIZaXPfxqwPDZMJcb1+0mUHtQQjVrt/A==
X-Received: by 2002:a17:90a:2351:: with SMTP id f75mr3656162pje.133.1582616314387;
        Mon, 24 Feb 2020 23:38:34 -0800 (PST)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id cx18sm1892194pjb.26.2020.02.24.23.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 23:38:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: How to flip +F to inode attribute in ext4?
Date:   Tue, 25 Feb 2020 00:38:29 -0700
Message-Id: <18CDA7E7-BD5D-41BF-A4C0-CE1AC5E1868E@dilger.ca>
References: <CAB3eZfsT6qBmqPmBxb=uMgh=7SV2LiKi-8OJTj08AfAPsGGw_g@mail.gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
In-Reply-To: <CAB3eZfsT6qBmqPmBxb=uMgh=7SV2LiKi-8OJTj08AfAPsGGw_g@mail.gmail.com>
To:     lampahome <pahome.chen@mirlab.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

You can use "chattr +F /path/to/dir". It may be that the directory must be e=
mpty to do this, I'm not sure. It may be documented in the chattr man page.=20=


You may also need to update your e2fsprogs to 1.45.latest for this feature t=
o be available.=20

Cheers, Andreas

> On Feb 24, 2020, at 20:48, lampahome <pahome.chen@mirlab.org> wrote:
>=20
> =EF=BB=BFI change to kernel5.4 and wants to setup folder to be case-insens=
itive.
>=20
> I saw this line in doc:
> "enabled by flipping +F to inode attribute"
>=20
> Should I use somewhat command to modify attribute? or mount with
> additional options?
>=20
> thx
