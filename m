Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C8E445D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404168AbfFMQq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:46:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40675 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbfFMFIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 01:08:00 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so14946079ioc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 22:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=45UZxQiFbq2zrCxPgxX4tICqpmAKAWmhy8nY0NTFEHI=;
        b=IvYoPJ2rqlgBJSEkbOmPNQ4T8snci1aUDjP4i5ni+v01yQixr/haGHMN5XMfefgp+o
         gA0/P7geGywk6GcvfeUiGnP1d9Kos6X5Sq+Cb81jepNDhUktjLmGirOoRjK1zb4hlJ9r
         89GJZKKLJeP4aRL67BpWfB2AFd69jTLo/hU9bjcij9zRQ+JMMYCC8u5CexJc1J4D7ouk
         675vvxvoWNWgrfNmwBTRUcnY6Dp9A/paKyMN3REfKtmlz2tPgGL9ETDDtP8tKYYFeSYT
         FGbk4S3rWYDi9qWs1/WlkIMoD3BQ1odSc7LE+RJJhmFeJGjWCrii1/PZmlxyPd9qoCKf
         ZXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=45UZxQiFbq2zrCxPgxX4tICqpmAKAWmhy8nY0NTFEHI=;
        b=IGNABJbTr5rGIbYZxnvWrfzURK+WiwCE5mkLUTwga4HFA0uou8voEHfr/wCU8u39fP
         RdaEqqmP2kb5urAma3Cy4+9mqMp/b0unXONDwM2s/mXwlPAHfoVO/m7XOJR9tiIH99/H
         MK8V+6LD5miFxkTA8SMQBLatU0V0KXEbNmoxTDIa1UlSsiTiFZaKtsy9lHLv4C62nTJh
         rG4A90e8EUjvJwQVoW273+OdSZ/wdAmD23ojdM/icvxab4x/a9Io+92nEfSSDxtpZll1
         kDUJSR/weuo/YsGSAni7vx/I1JDSNHyVJFEDT+2DWiEizEVUGKW2yev04JVQJYOurc17
         I+rw==
X-Gm-Message-State: APjAAAVQH3iordreM9d9DTC11Sl0wzGWWXxznoDlyzhnn24EGbjW2z0D
        EYHg0lM8n8c5T4MskyDF0G7jM7IA86We6kBHvu0=
X-Google-Smtp-Source: APXvYqxgNqmJzhCqu6nDA9Brh2cCec6hf5hucJv8U2qn/eilNBnXWBblhSJbLBujjG0hmPsx9vn0S7Vv2H3Cq8FtQu8=
X-Received: by 2002:a05:6602:1d2:: with SMTP id w18mr11313080iot.157.1560402479580;
 Wed, 12 Jun 2019 22:07:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: ste1959bury@gmail.com
Received: by 2002:a6b:4e0b:0:0:0:0:0 with HTTP; Wed, 12 Jun 2019 22:07:55
 -0700 (PDT)
From:   Steven Utonbury <stev1959bury@gmail.com>
Date:   Thu, 13 Jun 2019 06:07:55 +0100
X-Google-Sender-Auth: I0ZtVHmzy7pSCCKHdUpX4uqDIRA
Message-ID: <CAGn4Caj-vkVruo5W3Bof3qFYk=1ijZcC9NcEittLVjOpNYpgPg@mail.gmail.com>
Subject: =?UTF-8?B?16nXnNeV150=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

16nXnNeV150sDQoNCtee16bXpNeUINec16nXnteV16Ig157XnteaINei15wg15TXk9eV15Ai15wg
16nXnNeX16rXmSDXnNeaINen15XXk9edINec15vXnyDXnNeS15HXmSDXlNeU16TXp9eT15Qg16nX
oNei16nXlSDXkdeR16DXpyDXm9eQ158NCtei15wg15nXk9eZINeU15zXp9eV15cg16nXnNeZINee
15DXldeX16gsINeQ16DXmSDXpteo15nXmiDXnNeq16og15zXmiDXkNeqINeU157XmdeT16Ig16LX
nCDXkNeZ15og15zXlNep15nXkiDXnteY16jXlCDXlteVLg0K15DXoNeQINeg16HXlCDXnNeX15bX
ldeoINeQ15zXmS4NCg0K15HXkdeo15vXlA0K16HXmNeZ15HXnw0K
