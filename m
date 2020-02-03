Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 270D315092A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 16:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgBCPI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 10:08:57 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51847 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgBCPI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:08:57 -0500
Received: by mail-wm1-f43.google.com with SMTP id t23so16336698wmi.1;
        Mon, 03 Feb 2020 07:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Nb7hvXDQ9+r6z44arPAgwdnw9IiSRV2K+tFdLqVRakA=;
        b=Wx7WNp47ye9WQI5tLxZtGOS5HGupzUHFCmCLQp9ogj1JgY+bKYBrVYFx8s7Wm5Bjdu
         e8lI3ShklRD8PQSOmUelAGYF1O6+pi/c+EYNlccc1PNHuQL+WFB9GNGol4p6NpZajPNG
         JelJYEWOoNP+xa105kpvyKbskjYgcuYo72OOVnsnRgmIaRx8gNQ/vuBJkOyniiZKBwDE
         zYazYaPjQRtj6Vg1O646q3CFmGverB3ZX7L/sdD8XiI27lb/odfFmnHOckPUponhLuvS
         P7DHc9EfmQGdw8S3DSN15PNhC6jbHUQq9thj7zEMiViQHkx/Drv4CT18jOGiB7F36Pqt
         Y/3Q==
X-Gm-Message-State: APjAAAUE4TYs5HazcIU9VPhbIMvllSyzbMPkgwb7Xor96YxDn4ej1eZK
        DVup6SpjtWBZFNieznVe+ew=
X-Google-Smtp-Source: APXvYqwYR0n3m3mLqJpZccQmrqIWXWn4VJyZq+JDFfA34cOGIPsTUo8QqMknBd8okMrqVEgN1kh4fw==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr29217121wma.8.1580742534061;
        Mon, 03 Feb 2020 07:08:54 -0800 (PST)
Received: from Johanness-MBP.fritz.box (ppp-46-244-208-208.dynamic.mnet-online.de. [46.244.208.208])
        by smtp.gmail.com with ESMTPSA id h2sm26509205wrt.45.2020.02.03.07.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 07:08:53 -0800 (PST)
Subject: Re: [PATCH v10 2/2] zonefs: Add documentation
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
References: <20200129131118.998939-1-damien.lemoal@wdc.com>
 <20200129131118.998939-3-damien.lemoal@wdc.com>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <893ad979-7a96-8f74-ec68-157084224342@kernel.org>
Date:   Mon, 3 Feb 2020 16:08:52 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129131118.998939-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jth@kernel.org>
