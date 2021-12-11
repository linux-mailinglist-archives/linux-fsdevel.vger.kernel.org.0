Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF134716FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 22:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhLKV6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 16:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhLKV6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:58:20 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2116C0698C4
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Dec 2021 13:58:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l25so40943795eda.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Dec 2021 13:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hD0jfu1MWy/UXBkBYsVvOAZPApZLyir6gKavdc4BceI=;
        b=SOBkDHN1upt351fJGA10IENq8Lskn6OtfiA/mtFXWwbxNo6rK0VqMIikUbNdR10QL9
         NEz57nH7+DwD4ui2QjR5G0PDUg/x30DeYlpAViKmfLpj6c8owgTXHIRe2HlXrWJIYspc
         p1qexb7VgQzyxOs2U317jKWC2PVt5FsJQNP/qzuU8HlodfKZxoIrg2Y5u0+UlgiuF7n+
         KF6xHlFhNhhV0WZH+n1XpQNFkro1//sIniT/eC7+Qq7omDixZHJ42uWefxucVRQsgqoP
         MP9jAyQEdDJw2KiXunMshfyB4wcDGfWvxehuLHSr6op0i/Er4qRI4zT2OKxsbV2QjSnP
         PYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=hD0jfu1MWy/UXBkBYsVvOAZPApZLyir6gKavdc4BceI=;
        b=lIjfnKO0hM9/t1gfXKW/rZkHFfJz/C+s2VPf9nyIuEvNEt2VBr3eWX9TqtYsWvXwzb
         qazyOlnGxAy0BenMDp75x+wlnb8cODHrgdEKqWBsCzfAh42XdnAcwQgKD0j7h0rrBWov
         PCogH7/Ew6+kAhogbd2+PtoKvFiFvzB//HyvhEgLwcO5iorPoPHpqZbz8pEGxbmQo65W
         QCyBvEiseW9HOFFwS+XXvHk4qx+JFO18RlupXm9+5xFTdv5MZKwYCnPXKVylbrJb9Ecs
         0jNJLNn0zqYB/a+89/ixBlAyFbId95n1VHimgg0N9g4nX4bQCrQn8WsCDjSxSraOkefE
         i1Ng==
X-Gm-Message-State: AOAM530A54O+1ArqqKaET+jldyeKZEkYuhntZbbcb3lCfW/qtlY+5Rt0
        kOirKf/ET85uFD1fDPHkgsDMhJvLc9mbJ80LpUc=
X-Google-Smtp-Source: ABdhPJxTVLquc00JfCv8xmVg6F+Df36Ax6F8m8eI1vWHtjjPBaUzu2dvtxl/29t2QJINStCFpJhLct20UqzajIEroTA=
X-Received: by 2002:a17:907:6da2:: with SMTP id sb34mr33325880ejc.509.1639259897490;
 Sat, 11 Dec 2021 13:58:17 -0800 (PST)
MIME-Version: 1.0
Reply-To: martinafrancis022@gmail.com
Sender: rebeccaalhajidangombe@gmail.com
Received: by 2002:a17:907:94d3:0:0:0:0 with HTTP; Sat, 11 Dec 2021 13:58:16
 -0800 (PST)
From:   Martina Francis <martinafrancis61@gmail.com>
Date:   Sat, 11 Dec 2021 13:58:16 -0800
X-Google-Sender-Auth: QI6h_ccu4Os7HpLN5lf7FmNkMqQ
Message-ID: <CANadOMYJBdKak2aObykULF4gdU88=OTR03g+XDqpCofMfFracg@mail.gmail.com>
Subject: Bom Dia meu querido
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=20
Bom Dia meu querido,
Como vai voc=C3=AA hoje, meu nome =C3=A9 Dona Martina Francis, uma vi=C3=BA=
va doente.
Eu tenho um fundo de doa=C3=A7=C3=A3o de ($ 2.700.000,00 USD) MILH=C3=95ES =
que quero
doar atrav=C3=A9s de voc=C3=AA para ajudar os =C3=B3rf=C3=A3os, vi=C3=BAvas=
, deficientes
f=C3=ADsicos e casas de caridade.

Por favor, volte para mim imediatamente ap=C3=B3s ler esta mensagem para
obter mais detalhes sobre esta agenda humanit=C3=A1ria.

Deus te aben=C3=A7oe enquanto espero sua resposta.
Sua irm=C3=A3.

Sra. Martina Francis.
