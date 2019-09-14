Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0759B2B68
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2019 15:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfINNkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Sep 2019 09:40:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36607 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbfINNkU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Sep 2019 09:40:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so19832270pfr.3;
        Sat, 14 Sep 2019 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGd0Nsf8r1SfWs/Ru1bBbfL8JHhL34BqVq++qP9ktxo=;
        b=gr/af5E7uh/eclxKy3/AKgBeqQlB+53jhLBMucilUiHjS1JUk00+CEHijqFKWuHjvG
         M2uwYHq2JyEVYYzUrpAGp5FvpcIGL3Gy4w3stGtsVEhu66pSfKeU5JR8avuE/qJA6Tv2
         2EmZtq8H4HrvhxAV54U4J+K7FK68Q5UNsr6pXKZTlfQz2BDqFJLJQat9+ohrKeIK+Ci4
         oU0ijH4lPXb05FPq6NHcUOt2DamTTODNSnv4W9zvrJgzEa86nxd6nqAjr9fqgc6p47ST
         Mu05OFXb+qLgGAj2oOvkFRJ7qKIfwDSRaAxhdKSXMWizl5zmH9VllUGroPLu1scnSPj/
         J2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGd0Nsf8r1SfWs/Ru1bBbfL8JHhL34BqVq++qP9ktxo=;
        b=fpk27kYDBCRVWAv3MFTMzymoKcmoRJUn2tFnahJAic5MS8C6BKYat+pTX3203lFU+L
         stZ0xTAmWLzhZKAppSU9yCzEEbsKvshPsUVht9uOoUB8L1zBVCtOYF8QwIRMdJ4wdyR6
         pB8GwOr1AIQNNJYVRdzfJaxNK7MIQxHFpq9Cx3MpegRaUUOsMyuuoYt3oDeTkzeyxqoW
         EX0i6qNEO6ViGzuNAcocFinMQhqrHVzUfBNi3G4O6cPa1Jnan6n9mpxl3HeQ59PDDLvz
         sxAwYIg9tOmd/WoWJvdVo8/69PK/U2B1XeSnSICpajc9sOBhLvKpoQ0w+07tZrUp3qQj
         HKBA==
X-Gm-Message-State: APjAAAXwJd9BbEe/yGVEoGEUmstp9E5Hzq1ASI/3rLyM4BHjac56O2xF
        qv/i3/ZongY16TgxsqbfmGE=
X-Google-Smtp-Source: APXvYqzPBdEMLarV6HxcOp/P3+qDK4rs/ZTQxq3kCZlCdJc64XysdI4AUcwdx8zzGLH6WkwHmLlQng==
X-Received: by 2002:a63:5a0a:: with SMTP id o10mr48642930pgb.282.1568468419959;
        Sat, 14 Sep 2019 06:40:19 -0700 (PDT)
Received: from localhost.localdomain ([211.34.238.221])
        by smtp.gmail.com with ESMTPSA id h70sm26992902pgc.36.2019.09.14.06.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 06:40:19 -0700 (PDT)
From:   Park Ju Hyung <qkrwngud825@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     alexander.levin@microsoft.com, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        valdis.kletnieks@vt.edu
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to 
Date:   Sat, 14 Sep 2019 22:39:51 +0900
Message-Id: <20190914133951.16501-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190828160817.6250-1-gregkh@linuxfoundation.org>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi.

I just noticed that this exfat-staging drivers are based on the old 
Samsung's 1.x exFAT drivers.

I've been working to get the newer Samsung's driver(now named "sdFAT") 
to fit better for general Linux users, and I believe it can provide a 
better base for the community to work on(and hopefully complies better 
to the mainline coding standard).

GitHub link
https://github.com/arter97/exfat-linux

I also included some rudimentary benchmark results.

I encourage mainline developers to explore this driver base and see if 
it's worth to switch, since it's the early days of exfat-staging.

To others watching this thread:
It's more than likely that you can start using exFAT reliably right 
away by following the link above. It's tested on all major LTS kernels 
ranging from 3.4 to 4.19 and the ones Canonical uses for Ubuntu: 3.4, 
3.10, 3.18, 4.1, 4.4, 4.9, 4.14, 4.19 and 4.15, 5.0, 5.2, and 5.3-rc.

Thanks.
