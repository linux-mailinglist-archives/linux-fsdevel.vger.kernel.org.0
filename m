Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1E3698247
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 18:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjBORgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 12:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBORgy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:36:54 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0172A154;
        Wed, 15 Feb 2023 09:36:52 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id j5so11651458vsc.8;
        Wed, 15 Feb 2023 09:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D/KbAz5FeBvde1DWwl9iOIWYjZFr9YJ9qIF1/orABb4=;
        b=cYriOyhdNuA2EoNNZXNy8xPtjOPisuyaTfco6+x0PjLBbTswJBsYT4Fwt2qOSWPO8P
         dGFe0Wy45dR2Ls/fygoyz2AMcyfuBs69+rPHB/9WlL/Gk7hucnCcHOaEr+vBxM9b9JxT
         R2icLxUhzRNM1iFWGmGvoB2yT6U9Fwk7fQDojLUQuZXvstlbNTWDFDyAy550jzB5uYuh
         /jBGmeATOLlD80kMZZuX3Rm8LcIjjkMP+96z5OrEr4n6GU+lpccryZdLrDaxXK2HZCjN
         86Jj4niv0FnG0A2l0lyqMtIC969ym85sc2EI8dcOYDwjKL5y8gTBNQ7+ucfAeNlS8Zeg
         t0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/KbAz5FeBvde1DWwl9iOIWYjZFr9YJ9qIF1/orABb4=;
        b=c/uhirYKPnyGuaLq9iCJpnI6BuvQmpqte2TbGQ9Nl65Nr2SubvIIs9RZJrRbEmmsIi
         MEhrhb54OBIZj3rG4Yrg3Sq89f6lG0tpgKFdFcZcQZsddFdoLfSK2fMeRZzuNjYuV4sL
         CdbqU4EppU5rDJEyfwOpyZPct9oEECUoTaLDRk6NkJmXu6cbhP3FwjxAsginc0hsyCJN
         nCzkpIxagSxHBRkQWFoWYcxiGZSeeysejjtpzAhwY/36vSxU2RgxDuu+fMVvoHahlyb9
         aoQCBtJzaF5WrMrE69Z1uyR5oSsfVq2Qo7n7BWWasqvC7Q2JoF7OX1zD7IDDyEu11JPk
         lN5Q==
X-Gm-Message-State: AO0yUKVoe7MlLBp4bf+Jh/GfFM0a/iZAdRVP3X3h1D/YliQcMRTAYt8A
        +alsN6pDX2kXsm313gK9b6MURdCcqw4K3IQqNTUZw/Ee41Q=
X-Google-Smtp-Source: AK7set9t//t+6BdnqgMCsubhUnUjEi3iNV6s16IQ0BY9MHTtCZkXx9TuWw2aBnkLQElmbsc+smedsNFcrl6WEVmSZQo=
X-Received: by 2002:a67:ef41:0:b0:401:57f8:7c18 with SMTP id
 k1-20020a67ef41000000b0040157f87c18mr534314vsr.51.1676482611590; Wed, 15 Feb
 2023 09:36:51 -0800 (PST)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 15 Feb 2023 23:06:40 +0530
Message-ID: <CAOuPNLgTWNMSaZmE4UzOq8UhsLWnBzyt0xwsO=dS9NpQxh-h_g@mail.gmail.com>
Subject: 
To:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We are seeing below "ubi errors" during booting.
Although this does not cause any functionality break, I am wondering
if there is any way to fix it ?
We are using Kernel 4.14 with UBI and squashfs (ubiblock) as volumes,
and with systemd.

Anybody have experienced the similar logs with ubi/squashfs and
figured out a way to avoid it ?
It seems like these open volumes are called twice, thus error -16
indicates (device or resource busy).
Or, are these logs expected because of squashfs or ubiblock ?
Or, do we need to add anything related to udev-rules ?

{
....
[  129.394789] ubi0 error: ubi_open_volume: cannot open device 0,
volume 6, error -16
[  129.486498] ubi0 error: ubi_open_volume: cannot open device 0,
volume 7, error -16
[  129.546582] ubi0 error: ubi_open_volume: cannot open device 0,
volume 8, error -16
[  129.645014] ubi0 error: ubi_open_volume: cannot open device 0,
volume 9, error -16
[  129.676456] ubi0 error: ubi_open_volume: cannot open device 0,
volume 6, error -16
[  129.706655] ubi0 error: ubi_open_volume: cannot open device 0,
volume 10, error -16
[  129.732740] ubi0 error: ubi_open_volume: cannot open device 0,
volume 7, error -16
[  129.811111] ubi0 error: ubi_open_volume: cannot open device 0,
volume 8, error -16
[  129.852308] ubi0 error: ubi_open_volume: cannot open device 0,
volume 9, error -16
[  129.923429] ubi0 error: ubi_open_volume: cannot open device 0,
volume 10, error -16

}

Thanks,
Pintu
