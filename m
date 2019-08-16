Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF429005D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 12:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfHPK6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 06:58:03 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:46722 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfHPK6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:58:03 -0400
Received: by mail-io1-f48.google.com with SMTP id x4so5294915iog.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2019 03:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+lrkVNt5YGKheD75rVzVgYdoXjJTof5SmG6B1Qnkci8=;
        b=u2ye3u0bttk/wFPuwgBD3GQPL5o6GtNRGdNtR8y73GW5IUvZTWGKS/2umUo5wIccOy
         l16DtEt9PAu1tFu5Fk1N5IrvGfKUJi5eLKGUV7YcOf8o9veHCWx9jG2aag/D7Pwi2PB5
         atuAPOWFWw6xfv1S2dZ5y2DrU14MEYB/y3shB6UbYxdVmfkDo5ojWlvamXzXTRtW6tlH
         TjaVvXzoft2WC1tIzMlmsNFQdecFHl+zTGeDgARLtltT8KnK1VIS89MUuTW2GnGpnIO1
         smlmil/13BU4E2UHE/Tox91hO0LnNKg2CG3RQVYLLRoOrZz0HsyOEe2qK1CwhMF/1pur
         86xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+lrkVNt5YGKheD75rVzVgYdoXjJTof5SmG6B1Qnkci8=;
        b=J69QqOzan4MOtbxfjvQKRwaKr9OeK0/jP1bIZCcEg6vta+JkpUZqEtiWNaM/fbYNdu
         KjTn+WPSZFNEkOu17bAyDX7Rd/ZBo5Gky1jscEHjOKFjj+p3UFgVjR4aIHLo5c6c2Eg+
         FXYpbXw6PCIQrpAhsQ4quDbNVbi6HKIW1RKD0LLM5NqvLcb/i6VNJ8Q9sFFFDt6BlfSZ
         7YagHMDRBZNZmLlXapQBl7lazno2edJc8jOh52PAjdY/BuErH3LnMg4xmwMAbNZJU644
         rimX8tRfIAUxWYWDn0UR5wn0seLGHdgugsGI2lkhyIg6f2QtlMJOX/pQphkpXTn6nGPO
         w/Uw==
X-Gm-Message-State: APjAAAWuqW2mUupsrckqnwadwXv425aYnx9t9glTctmwpJu6B0T+KETL
        Y5LjM+DnSzv0LhKfAkYS24ah8Wz51k6XvvhLiOZNI1mi
X-Google-Smtp-Source: APXvYqxjCin27LHWU7JIuiLWtpPC0bIAyWi5CxofuIMsEFb/nuufCVWy+K2URiMIAxsRlegQsUjUMa7ubAp1/AvAizs=
X-Received: by 2002:a05:6638:a12:: with SMTP id 18mr855107jan.123.1565953081924;
 Fri, 16 Aug 2019 03:58:01 -0700 (PDT)
MIME-Version: 1.0
From:   Denis Solonkov <solonkovda@gmail.com>
Date:   Fri, 16 Aug 2019 12:57:25 +0200
Message-ID: <CAPk=LjpzRG4q9DXSQ1kHU6=RmGXkhxYvnUKJTYnaNwMWanDmjw@mail.gmail.com>
Subject: PROBLEM: Wrongly calculate AT_PHDR for ELF auxiliary vectors.
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I have found a potential bug in binfmt_elf.c, which was already filed
on bugzilla(https://bugzilla.kernel.org/show_bug.cgi?id=197921), but
didn't receive any responce since 2017. I assume it happened because
the bug was filed in other/other category.

get_maintainer.pl pointed at this mailing list, so I am redirecting
the bug to it, since the issue is still present.

Kind regards,
Denis.
