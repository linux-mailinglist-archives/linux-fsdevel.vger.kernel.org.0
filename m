Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C68660E05
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 11:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjAGKnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Jan 2023 05:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbjAGKnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:43:39 -0500
X-Greylist: delayed 408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Jan 2023 02:43:38 PST
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [IPv6:2001:67c:2050:102:465::206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D26FA
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jan 2023 02:43:37 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4NpxTN1wCjz9sRW;
        Sat,  7 Jan 2023 11:36:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1673087800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gTA+kL4h+dSKk2rXTbjkecVGdH74QHMOs6IIguLVFfw=;
        b=i7jjxlBi/OTf0nc3SDJK7r2o5kK+x7rGewISfC2SdeJ/9ypQuwL3kWwbIxrT9YedKaGcZu
        iJ2/Y3fnPQFPCl/bYVmDprpnzLfBCeQycv4GsVY57Y0MMSv9feRBl23KtoTlZWuj4YGSlm
        qwJxftz9ZcnkoZoIX+unmr2Sf27zFVtksv1nGsJGC/ZxUcR3L7YVCq+KTkbnkNA7JIPOny
        Q7INhmFxNuNvexyGKg2hljh+ErHUtAvcToQEamSKwyB0J5RkhCVigonWBs/64vKjBEXsNk
        bGORsKMzQ1hGfTNBECugskhLrAP5t2TJ0qIIxLuZ8C7nKnJWiMoUaoAnnjevjQ==
From:   Finn Behrens <fin@nyantec.com>
To:     rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Rust PROC FILESYSTEM abstractions
Date:   Sat, 07 Jan 2023 11:36:27 +0100
Message-ID: <4AE31CB6-53D9-45C9-B041-0D40370B9936@nyantec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; markup=markdown
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4NpxTN1wCjz9sRW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I=E2=80=99v started to implement the proc filesystem abstractions in rust=
, as I want to use it for a driver written in rust. Currently this requir=
es some rust code that is only in the rust branch, so does not apply onto=
 6.2-rc2.

My current work can be found here: https://github.com/Rust-for-Linux/linu=
x/pull/948

I plan to send a proper RFC patch, once I=E2=80=99v got a driver dependen=
t on that, to make sure the abstractions are actually useful and correctl=
y designed.

Finn
