Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A63E107551
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 17:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKVQBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 11:01:21 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37606 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfKVQBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:01:21 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so4251469qtk.4;
        Fri, 22 Nov 2019 08:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=CdX7ZQEUe/cRH9WC2wubBDri/lMHrSGbYedbb2yw4Hc=;
        b=VBSZIm/NitEgFgAiYMVXY43lq5XjFUUTjaYCUvPZMFM3pP+4Wn/Ra81LvNCG2B/dqJ
         O6+C4i5V5lsX27m/EGX/IIARNSgTmUZiXI5PQoF97enNrvv6/mJebzS5Yj5OAR21DDoX
         s4zlKfGVcczc06smz2ulDrS/Zl297SC6dcC64rH1OZ+gai2JvhSrKRBitBBnrTvQMaQg
         H+pzisp2xLarzHpVCLA2fOqxxjrKKkgP66m1mHkoy0m5a431z/fWNSOG/vzQ15Hs2ESN
         fXgp914i6/lDpaaL4j27zwbYHltwdJIRFp1dKQkcR6jleKZgd7L9hxRDjngn325S4xzk
         woCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=CdX7ZQEUe/cRH9WC2wubBDri/lMHrSGbYedbb2yw4Hc=;
        b=mRzhnBuqbjcrG48mEUpz1t54cXbTGjjIFQsr9kYhRRHL99DUNvn67LNFWNvKwayxav
         +U1eXMv3C9Kh4g4hDiMB1ZrveUf9lf/oQb1alZbE4AEJTF4WcNnQ/KqkK01GVL05GgRG
         Jj4Br20wVbYM2LgiOd4GevD8xXexUY+nll3LPBmBx3ImxBr5Qr4lD1WNWo8Tes/4EOos
         CBWhdQ1oDQm+SMFH7wDBF/ukBf2+9MBShwRwiZflzsw12ihRK7j5TOn0/0IsxMEim/0k
         9pKuhHUVotOxWm1Sfkrtxw9ZCSC5b5SB3em8ZGacPkYNyaENvvc+gVlxMXPV7pGKXKFB
         2vrQ==
X-Gm-Message-State: APjAAAWwlBR/BYOStCtQ8RZuUENEeFZo14gbLanQSE3ZU7LbaF2RO03V
        91zEx5pBQZsUzj1TaUPlMWNQJt2AgTJA4w==
X-Google-Smtp-Source: APXvYqxWtITWMvEHpWI203D+raKApDrbUfvSAVn8EvwssACZseFHVbt5V5RSqvf9csq4q2LiWohHOQ==
X-Received: by 2002:ac8:1415:: with SMTP id k21mr4959630qtj.80.1574438477243;
        Fri, 22 Nov 2019 08:01:17 -0800 (PST)
Received: from [192.168.1.164] (pool-108-20-37-130.bstnma.fios.verizon.net. [108.20.37.130])
        by smtp.gmail.com with ESMTPSA id m27sm2196315qta.21.2019.11.22.08.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 08:01:15 -0800 (PST)
From:   Ric Wheeler <ricwheeler@gmail.com>
Subject: USENIX Vault - open source storage call for talks - CFP deadline
 extended
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
Cc:     Vault '20 Program Co-Chairs <vault20chairs@usenix.org>
Message-ID: <727e2a7a-eab7-9ba7-e1b8-d75eb853245a@gmail.com>
Date:   Fri, 22 Nov 2019 11:01:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

We decided to push the CFP deadline for USENIX Vault back until Dec 3rd given 
the holiday and some slowness we had in opening the CFP site. We already have a 
good set of submissions, so please do submit any talk ideas as soon as possible.

See here for more information on how to submit your talk proposals:

https://www.usenix.org/conference/vault20

Hope to see you all there!



