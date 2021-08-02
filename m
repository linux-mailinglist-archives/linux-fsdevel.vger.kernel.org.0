Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47963DCE9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 04:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhHBCHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Aug 2021 22:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhHBCHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Aug 2021 22:07:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14411C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Aug 2021 19:07:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so22576388pjh.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Aug 2021 19:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4UJ4VdvnjH1UiyxFLhfo4+Yb9Ryf1kMpy89iq5kXl0w=;
        b=h4Gon6qMPYDo2lsCs4PsNoGy80tLzXuEToQdbh2o9jopf5bYBAOz17DzX5JaPAglWB
         ZspMHGwhwV0o7ZQ20LtmH9fgw6C4yfLjrkIARS/2L1EXq+jWkN8FWM4RB5YyvIb6mzC1
         m6h+5KUq36Oj5KeOZnHwRKTo27klJiR4uZa4FhRW+HYGa/YykFVO2BNcYvUAmroyGRNt
         x9xa85jeHijocjr1kD0MBE5Qg4neTYrmSYVWRd0Q3GCTQMThKhcbWFR7+F0AkEo0DANr
         sf3fQqrxIuhyxDLle8TtzWhvOR0BUaQE1aZ2Kdm94AxoWD58nTg1ufcffywHSrdGAjZV
         nabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=4UJ4VdvnjH1UiyxFLhfo4+Yb9Ryf1kMpy89iq5kXl0w=;
        b=o3C98XhhNF3q2TwFnd5FUqJ+F80SBDn+mdyGewrHER+VZujG90wZs3qAfojzFcf2Yh
         5NemqIIVG0k+binjryGoEqxs5ph2FHqKDO0vvDFKKOYfgK0tnRmFIiL/+eD9MmLtKcOb
         E9MjUw6WO7RTw4hXImNO5HCfmGoj4tZlDqdFEB0y+1raBpZgzfXORTszjmFTF7hBAt8l
         XpkFY6NwhgZECoN4BFtEhP5Em5HkGiB2z3JT8YKZb+/XStBmLIOs6aXgJUlfOE8MzVJs
         Gp65civ409ZMiXFPet00d7eG36zEQzhxEeU1BfHeisUnJiwSabFVHHpIVmzd6Ck29rNr
         nFzg==
X-Gm-Message-State: AOAM533EIH7T2hmAPEkZDRWwwaPOKXuGGh/yr4IdA0U0B6LtzHhESzeH
        FspG0WwnWBXBotlsftoOMLDcTbj6wJgSoRURWA4=
X-Google-Smtp-Source: ABdhPJyOoupAo8Qe/sm/nCwgsoJC1nu7lAjOxrDsoi3uqYjV6ajsfiX1AfQn3wz4FVcemphN/47bcesD7pegSSIGb1A=
X-Received: by 2002:a17:90a:ab07:: with SMTP id m7mr14556713pjq.27.1627870028713;
 Sun, 01 Aug 2021 19:07:08 -0700 (PDT)
MIME-Version: 1.0
Sender: corinekoudeabo7@gmail.com
Received: by 2002:a17:90a:3e44:0:0:0:0 with HTTP; Sun, 1 Aug 2021 19:07:08
 -0700 (PDT)
From:   Kayla <sgtkaylamanthey612@gmail.com>
Date:   Mon, 2 Aug 2021 03:07:08 +0100
X-Google-Sender-Auth: lQ-NHrB6TO0Csl69uz_279MfFKE
Message-ID: <CAM5npYuJUZpt2uGZux3yUBQ0bhm+jhX_r+epfq1zLG3rP0ThYA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=C5=BDivjo, ali ste prejeli moja dva prej=C5=A1nja sporo=C4=8Dila? prosim p=
reverite
in mi odgovorite.
