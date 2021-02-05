Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF118310336
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 04:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBEDJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 22:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBEDJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 22:09:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12302C06178A;
        Thu,  4 Feb 2021 19:08:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j11so4806535wmi.3;
        Thu, 04 Feb 2021 19:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=hqf55dXwvcYwwL4sAkoYuOM6RPu6wxeec88n5sMRYiY=;
        b=qKV6lK/xTrI0xWZI/8Vwj4HWtece1YWaUDe9sPcNOebT0x9iH9t9HcfJIQkpWQqu4j
         9tLsV973I65GjSCqyS40JivInipCupY+1WZAfBNpdOynDt+97z63FrcpdVze5raYfFI1
         ELiZ/G9wyN0fnfIjx/4fXB0vrZdvzQZF98iXIaty+2RnmRohcZKyquzcoEI7HJVOKKX+
         EiIOfD4L+JHLtQCVKSDCCxXZVCK4MxNFtPjEIW4ZVaTqiXLcosgUnVu2mpqrz5slCIU6
         OojTwfk4ppz8i2nlpZs6lLbHMceui26pWhk6A71VZRttpKbJam5k9i/jzM4/k1VhIFAv
         //BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=hqf55dXwvcYwwL4sAkoYuOM6RPu6wxeec88n5sMRYiY=;
        b=fGZY9xPP13GVBXXMytLVmy4dUT3ZCBl7ro2iO2tzQB9V6NtlHlU1WIffRCKLZpGpFs
         TunlGsH4Zvq3K0GInppg3DWQ6nFY9zo9OCTlLbfqbcT/PQPkayTxHnhgG2AAoU5/1HfN
         VVucPa+R3cd9on/7Iwf4zdH1ndpzYsxtKOnL6VSymQawxuZsW8hrz9e2OeLzl/dgaQK9
         HWox4Vg3ubaB7uc8Cr/eNL0mbPl41XDD6k59/uPPLfyvGi2GihpvQ5611x2QMqQ2sXYc
         SWixN9YRCcnHIfjyWkM9XdAjD15+wAcu2Pbtukm6aIqL6TRZflV0fIny7xopeB0Td1ei
         oFpg==
X-Gm-Message-State: AOAM530acKnINW+aC3ADGhAO15HtsmlJf59mPZLjJWA5yurPXOhlWe0j
        flfCEAyHDuKpQDhkTU0jfxbUDMcg6nY66w==
X-Google-Smtp-Source: ABdhPJzMvxq+Dz6Cd25sA4YjrzKq+MpOJZGous+0kvBheLF8WnJDbF6X9Nj/FnREqpI7o/SY4LFdpA==
X-Received: by 2002:a1c:3185:: with SMTP id x127mr1593295wmx.117.1612494508861;
        Thu, 04 Feb 2021 19:08:28 -0800 (PST)
Received: from [192.168.1.6] ([154.124.28.35])
        by smtp.gmail.com with ESMTPSA id n9sm10836813wrq.41.2021.02.04.19.08.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2021 19:08:27 -0800 (PST)
Message-ID: <601cb6ab.1c69fb81.5ea54.2ea9@mx.google.com>
Sender: Skylar Anderson <barr.markimmbayie@gmail.com>
From:   calantha camara <sgt.andersonskylar0@gmail.com>
X-Google-Original-From: calantha camara
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: hi dear
To:     Recipients <calantha@vger.kernel.org>
Date:   Fri, 05 Feb 2021 03:08:17 +0000
Reply-To: calanthac20@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

do you speak Eglish
