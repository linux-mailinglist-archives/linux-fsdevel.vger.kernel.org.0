Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E519C175679
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 10:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCBJAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 04:00:40 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:33926 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCBJAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:00:40 -0500
Received: by mail-lj1-f180.google.com with SMTP id x7so10853806ljc.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 01:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirlab-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ILdlodRtDcKj5bc7KTg1YNktlCusGb39Kfea9Nfj3nc=;
        b=P/AlFYZEgWwT8v5KK9jbSPAMdUlH/wMzFe6+2acYJFiqHc10ANostAKqEoSpg9Zd9o
         20iW/hrz/v+k9GtgVzLB++OwbfOUQr+UK7FRFsC5iQ5anNH6GA9i/2EhuscJX0zwhHG8
         5BxDkr5Z9qms+naaG08+3atdG7l80qksQxF1OVHYhGD0C6enxZTOWeCX2ZfD8s0pRsb1
         QhuvVu2ASFuGaGZM5Z1YCrpu88Aca+P5hbIntEaifTaCh+SCuNOR2K6VUBFZcG3KsYif
         /Vt+W+AsKagSjlGRxWZPpduuK1LAed7ic4ddtJo5atJ2P3wsVGIc6A0+DVmd5080ToIz
         phJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ILdlodRtDcKj5bc7KTg1YNktlCusGb39Kfea9Nfj3nc=;
        b=quBq3LW1pOXqHxbWHNSQLVeDISOkq7SHEcjIuxiYEqcY4bkpILF3tfA5lXbwcA+eby
         i+ldj5qmOCIO6Xs7lCpgAzaFp7yFJl4yJs81RUXjJn8DwZnUf1OnAJzb7HfEYGMsEIOi
         eta90JxpAMCfr+X2OI5xCpNJZ4QQJpNCdrAMfmtVSuTrzdUGXB4hZ7BtxtS/rM2S5WH/
         +fbKpzmAdUJh1ZIeIh2O2+R38rOmlOsarerHhhCQ2+SNd+pdPIxylVewwSvRzSE/HXBT
         01XLmUZvVzYOuYIkN3O3WE2rwelNcl4KT+us3Xwzfie8ThAkMGZB88/xqtDla9wQVHGe
         V0nw==
X-Gm-Message-State: ANhLgQ2igk+ayYrPtIPYhbUKfS69SEeCl00PWGAGnF5e4hqvAh7az5ff
        Ha5i8h6B4xu33LRR0y7GhUGeVmpLgRS84qtuOTA1AUWi
X-Google-Smtp-Source: ADFU+vvakPEdpHrRed4M+XJLh8yKYcnQSokH8NUCdR27xu9GNzTuzJUtJahpESOjKxAnZnZGlvzoze3k7V3MAZDczgo=
X-Received: by 2002:a2e:90d1:: with SMTP id o17mr11313533ljg.155.1583139637083;
 Mon, 02 Mar 2020 01:00:37 -0800 (PST)
MIME-Version: 1.0
From:   lampahome <pahome.chen@mirlab.org>
Date:   Mon, 2 Mar 2020 17:00:24 +0800
Message-ID: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
Subject: why do we need utf8 normalization when compare name?
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to case insensitive since kernel 5.2, d_compare will
transform string into normalized form and then compare.

But why do we need this normalization function? Could we just compare
by utf8 string?
