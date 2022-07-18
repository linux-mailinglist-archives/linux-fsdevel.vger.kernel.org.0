Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9A05784AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiGROCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiGROCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:02:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479A27CE8
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 07:02:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy29so20278079ejc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T7+XCjtZTU2Zb6D3WDEL9OTx9NGOHXfIAoUuZtkveYA=;
        b=q1V6uD8TuhB78vTN+KDplqxrPGDubeqVRBQo+e9Tko3lNGX9X1P47s1MmEY5Pm31CI
         FuXTDj5PKYg8c1yrev1fDzfBIGzAYBBd90l3L4MCjXs2KkBiD/C6JsgDuLA2a9PWBcwy
         my7Dy/RKi6adj0UFpReRfmlTSYKgnFP3QGeNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7+XCjtZTU2Zb6D3WDEL9OTx9NGOHXfIAoUuZtkveYA=;
        b=hMDseB/8CX1+4+f+ub/FyCdv3qiDtRZ1uPV6tMO/DoHl1ufO6ttqPDjP/pd9w0eS8B
         HtaOgywIj99tq/Z7Nbmz2imNuXJ/s/GGBudDa5iinNF3NqTgRShe+45zuFV4Aplmw5Fi
         7srWtca65u0hZgNc2hcXbk9/rIUUaKF3R6+8hPymnc8yZDE94hS5X1LaoOWv8zpgDY/T
         zFpfJ7P+N1DOBkVrtbwjn3ssLxlyBN6rxHNndWowrsUKlCBogxJ0VFlJ/O0Tr5fky1Ii
         XaSV4r/jXAgqzVeBiGvVvB9C5ZE2ueIZOqN/k4c6rsd5/7HExivqKoYDLv82QtlZAKzR
         c/DA==
X-Gm-Message-State: AJIora9fMvjXgBd5A/Q4M9iR0WNKQChr3nUhi1GWVI74Zv+dkt1hQF9j
        tMaqSTMmzkGg6l0W/042nWatyYyZcw2MateneMNQpw==
X-Google-Smtp-Source: AGRyM1sINVkqkNw50fk0vFkxhpnfW7MtSlhT2ItU3yC5D9a4yxlKg3D6PfKu7h51/fkRoh1hwsT5KpR3iPeNHR+wKKE=
X-Received: by 2002:a17:907:75f1:b0:72b:9e40:c1a9 with SMTP id
 jz17-20020a17090775f100b0072b9e40c1a9mr23970938ejc.523.1658152963182; Mon, 18
 Jul 2022 07:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220610020838.1543-1-wangdeming@inspur.com>
In-Reply-To: <20220610020838.1543-1-wangdeming@inspur.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 16:02:32 +0200
Message-ID: <CAJfpegsnYOPaNfdpaOZqkdmLQuwcSoefUC2LroLzeab6H1x=zQ@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: delete unused parameter for virtio_fs_cleanup_vqs
To:     Deming Wang <wangdeming@inspur.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 10 Jun 2022 at 04:08, Deming Wang <wangdeming@inspur.com> wrote:
>
> fs parameter not used. So, it needs to be deleted.
>
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

Thanks, applied.

Miklos
