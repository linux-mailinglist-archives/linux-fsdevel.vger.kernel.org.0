Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102AC14D8AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 11:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgA3KLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 05:11:41 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:36327 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:11:41 -0500
Received: by mail-pf1-f180.google.com with SMTP id 185so1255482pfv.3;
        Thu, 30 Jan 2020 02:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mz6Sg+1xlyo1RAumtR2m9UZfDaDkaYdFhbdbNKvWKs4=;
        b=HkOH7nZqbOyGwH1fu0ppaau8VwYWH0iMaAnnXrxYZPHWSes9zL4AVH4XpB9eO3PfQu
         If7eVjiU18TtgXymv1vpr02ZZBsZVv7x0VOLx3mDChU+bWjwMOGHtGWLpaSr22mBhTNl
         eqLWe4lJyL0z34vCcZTl7t0EFwsjvvRKic7DEYD4zHeYy3Jkmgv/DTW9xC0tbz6rTpuQ
         pJJTe5v5WP52nOPqs6XfOPsQzEV8uByt6ZaIwNPWvZNvG5nhr+wg5zX0W3qALk+10v7I
         nc16WMlE25YLLzE0JfcKyOBoA3pZk4wFAaROMMxAGBGgJy0DqC/f+UmsA9Uaf0KIhn7g
         FJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mz6Sg+1xlyo1RAumtR2m9UZfDaDkaYdFhbdbNKvWKs4=;
        b=ell5nPFShiileDRWMxcnpSjpv0IgVySLFrAZRnVCRfroUfJIkmuJaqIilpLlSTD5ma
         jBRM8rlJUPSFe8TUr0HmmoF18F7SnR751LYzQ4d+eSgZv+RvXw2VVWErPT4lanNeNrAN
         srfOzGWBodPbmM7WTGIlpcr1RF5KmrFhGHyblSwo4b3iGzVr+179GbVB38Hk2J/ucHwW
         K0xXUZtEZIEE2kn6AORV1OQR8jbGVuuqJ4pcOzMf4fPVPBdFUF/pUOl8Zb1Qf5W0H4jc
         S6raozXj+Ga17K2PxIFpQKNWWU35nMrUCiucTX6/81WHNNSuGL0JGRRpFoz2WM4kdzi0
         98dw==
X-Gm-Message-State: APjAAAVCusOvyW+kk0myOcvga/zoIE/GB+Hsjx2+rw3zDFsIEWxK6ZeL
        rhh6BEwuE2J2YghgTKJLcH1740S75zU=
X-Google-Smtp-Source: APXvYqxryqEa+v+/LI4WvWVdSwoiDVrYKw2NS71V1082sPc/hxKYLdwKiBOeldsH7+QUoiR81NFJAA==
X-Received: by 2002:a63:214e:: with SMTP id s14mr3857659pgm.428.1580379100984;
        Thu, 30 Jan 2020 02:11:40 -0800 (PST)
Received: from localhost.localdomain ([2405:204:848d:d4b5:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id k21sm6239683pfa.63.2020.01.30.02.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 02:11:40 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 0/2] Remove unused structures from source
Date:   Thu, 30 Jan 2020 15:41:16 +0530
Message-Id: <20200130101118.15936-1-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset removes following two unused structures from the source as
they are not referenced in any other file(s).
 -structure "part_info_t"
 -structure "dev_info_t"


Pragat Pandya (2):
  staging: exfat: Remove unused struct 'part_info_t'
  staging: exfat: Remove unused struct 'dev_info_t'

 drivers/staging/exfat/exfat.h | 10 ----------
 1 file changed, 10 deletions(-)

-- 
2.17.1

