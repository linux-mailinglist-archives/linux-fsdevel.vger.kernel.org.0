Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B65482AA9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jan 2022 10:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiABJbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jan 2022 04:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiABJbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jan 2022 04:31:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA784C061574
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jan 2022 01:31:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d9so64320482wrb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jan 2022 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=g8Z10qgIS0EarfPNyU/0T6kl3UEk/EndXdl7judHSI4=;
        b=UxGFTPm8WLZMlIZv9AsVsIi5N9kO2k/06aFM7B7qjyoz0YIhoaP74NKDc0o07t5pq1
         0ZVohK4q1+RDFcVXM5D3kWIT/2dF1LMfuPOQ2uc0emF2ZkJIvP4vvvuEqkHMwawlsMaN
         L9V+6yWk7u5GaF7fgHFHLMNj6nGewVj4ibj4cbil9395KY+qiXbUtVNZ/h7aZ/6WiF8s
         dGltNn3LlpRYApmmgdYsVyN4goEQHK4y6QhBj8sg77Q9k1jBV0PLUq62+2LdfmcctPey
         bQVycaRCra2EGFTKVKXnOxTi5D1QldCmxlSRkEjfHkT7x/XtSly7xPG5kE4G5swStXFS
         slcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=g8Z10qgIS0EarfPNyU/0T6kl3UEk/EndXdl7judHSI4=;
        b=jYdMmrAO5EMypECrty5RGlVFjCfNrwbsjtI7Fw3KRGLZ1pd0khcLuC2xyYKs1auCEC
         i02OTJbCtcPIu+HktNvGEj14knPWl1Z174SdIIkTbrZLbivWBQxLdH1OAlmXNZHGpFNW
         jWCmhQqzjFwZJ3QBSFbWzClRKsrCO7u/14PnKftry2kyzrLpC1kCgPsAJ2oEGuz69ATC
         Z/gePVzAun5UubM/0hNPCcI2xNHHuMF+O3mqJNkqNCf6yrSpOiwkdwn3ITZKEVOWCnCx
         EpzNa5qVmyjoKTKQI6ARNVx+0f+yjU7Wbjws9rqLS4ohdWUsdoMFGUGK151h9gSStvgB
         Ps5Q==
X-Gm-Message-State: AOAM530BFL2aTIOiQJRbTRCLWSdfzzyQdkNubGma3Ya5TmWaHwZMOmmb
        xpC0ARxqAPZJQcPlS1cE1OM=
X-Google-Smtp-Source: ABdhPJyNog2GOecbA55/Rx1LAgcSEWJ80pvvozBJIkevG5m1FKdVgIqDFBUMsyq8+GApm69GouxIBw==
X-Received: by 2002:a05:6000:15cd:: with SMTP id y13mr35380308wry.28.1641115892424;
        Sun, 02 Jan 2022 01:31:32 -0800 (PST)
Received: from [192.168.9.102] ([197.211.59.105])
        by smtp.gmail.com with ESMTPSA id g18sm30779774wmq.5.2022.01.02.01.31.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 02 Jan 2022 01:31:32 -0800 (PST)
Message-ID: <61d170f4.1c69fb81.68a1.027e@mx.google.com>
From:   Margaret Leung KO May-yee <richmanjatau@gmail.com>
X-Google-Original-From: Margaret Leung KO May-yee
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Sun, 02 Jan 2022 10:31:24 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mrs. Margaret Leung I have a business proposal for you reach at: la67737=
777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
