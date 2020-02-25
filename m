Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3716B831
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 04:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgBYDsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 22:48:33 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:40410 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgBYDsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:48:33 -0500
Received: by mail-lj1-f178.google.com with SMTP id n18so12440589ljo.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2020 19:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirlab-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=BdE6ucHq4pRy9/T8CzfnvtYmK0etY8BaSPf9biBg8Ko=;
        b=DCPbtLtJtfLVi/+T0mzMI8BQnSP9j3AkryEn1yvN0POpjmTm9JmXXaQUmLl6mAu93Z
         mmV02eYcffrWQeUQK9Yq6bKBOCh3xR+0Mq+tKiScinbwtpZw/OXkYTF2ljWN3axeljX0
         GptL0nSOjy8qudoo4rPUzsuECPTim73l6/QDlaKlmsBGS9iZI11ieYOc/fPRarfodAiz
         7gBiOlmXbIWe1JgMk7HfevSpsdzKm+RjBAyEiuCiyCLQMGDR02YymFs2JEXOKoU1Kapw
         9R0cUd6nf49Nk1R3F4/zCnZkT6UIvQGmwXisSDE3vmeSc9WJTUlwEKL6r4WH6DTxF8Wl
         wUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BdE6ucHq4pRy9/T8CzfnvtYmK0etY8BaSPf9biBg8Ko=;
        b=t1ooR11q1V1iAQQugqymMiW8xHDfqIIEkjV7IUh+wysRXcvHifc1b7EZNqikIC2zXP
         jCV7dMoi6zwPGjCzui2ff6ZhwpLCovV2PWBbgR7vwm+OX3dqaerlWOrx1pj3gaDMNj40
         FRLDkVbCfa1yVASTqI70Dgw8LkHnktoPFaOzbv1sk+yt1wpEudaIvZ1Rpfb1PgZYBYHb
         ntUFdDEbiZ2O9bmBGWpVhmDMFoHrYEklbLCA6hPbZBCPWi3ywEqO6IxDJX29/yL+4hqH
         4eLgfcdj3rfW41nGpxeP4fzfNHR9YAY0cQAYkBols3CNkoxTKrlykfydr4QtZqGh61qn
         M/Sw==
X-Gm-Message-State: APjAAAWrguN5fH2OUUPezfcEQ2PcI0h5dJ0VXU8KQP6GJ9u3SRc5NB2R
        mmuYFVVv/KmdzuqkvRSVel+IH4LLWVSDyjafiud5JC58
X-Google-Smtp-Source: APXvYqxa8700gntEBx60CFo7PdapW8cgV9yEjkjjFCsuvBh67qASHhiJ78+udsMA9cbatD+T3GNzPXpr7Y4m/yHGH1o=
X-Received: by 2002:a2e:9e43:: with SMTP id g3mr32880316ljk.37.1582602510972;
 Mon, 24 Feb 2020 19:48:30 -0800 (PST)
MIME-Version: 1.0
From:   lampahome <pahome.chen@mirlab.org>
Date:   Tue, 25 Feb 2020 11:48:18 +0800
Message-ID: <CAB3eZfsT6qBmqPmBxb=uMgh=7SV2LiKi-8OJTj08AfAPsGGw_g@mail.gmail.com>
Subject: How to flip +F to inode attribute in ext4?
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I change to kernel5.4 and wants to setup folder to be case-insensitive.

I saw this line in doc:
"enabled by flipping +F to inode attribute"

Should I use somewhat command to modify attribute? or mount with
additional options?

thx
