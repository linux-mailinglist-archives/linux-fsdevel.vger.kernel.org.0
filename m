Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9EDD6BCBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 15:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfGQNIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 09:08:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39430 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQNIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 09:08:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so11738836wmc.4;
        Wed, 17 Jul 2019 06:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h2yLsvzismF8aSznQ40gS7iVeJd2FnjlYb1X34YBrA8=;
        b=hTIrJmKdb4eBexEx/Rfsp2Pg7LnciIrsWX1mLz99xre2zIlgoiZaRCMFERkDAw8DDI
         5SSzeqshErtNi7bSc3tgUmHN3HPsgCWWlvGsy5P/jXXVo0NoNhymFSNuVUOA4bwJMwQq
         MtK+PW3Kf6jxpRM6/m4vtBsrRPTyXrgx/CfumOVFW75rvSeMeoGDLotXbLZ4dZj9XvW8
         zdFqWe7FC1i2CMy81xtbA8AfUzcU8z4KSd/Vr3Dpsm935/ni2Spayq5xnOomWsic77dq
         G/PfZx5IhgH+2aj5ZUt9rXZNbq+d9eLIiBIHkaNMX3oLc2RTPfkQ84cO11KPR8XNTi+r
         Hnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h2yLsvzismF8aSznQ40gS7iVeJd2FnjlYb1X34YBrA8=;
        b=O1e78+1J2f40rNBND+xZyUcC3m3V8AwikoMYItnpKQr22vdoVUePEX1gPcIsPzLDRF
         quwPWEU9mEhkQ3C/t43TALj/yJfZ22rTmDc19+kZn352qwjtXJBzoYDPjVh0e8CWyuIB
         VJ98Ue2AyFQpSVFMJ0nv9THVXR7DX/bCcdI8LCYXepO8+Ni5sLagLtvj124xPjoS8TYX
         fJ8DHGsZG+M8nTu3o2mOl1mN8d1ChFC+YXOLmAwGuQam4mpNo4bF2z49p6Qn7fbU+Yfw
         iz3CSAvQ7GqTKljuxw3jTVe6++1tIuy/sxNly4YjI4fCCG5m+gbLDHqF9+X/WP0FZ4qh
         4fDA==
X-Gm-Message-State: APjAAAXtsvPN2Iboe5msYUSDqHsIRdgStBMbDIp+OrqwVt85C7TSNwYJ
        ZyEDyeo077APxs+3FFhiC+/nXYEUVIk=
X-Google-Smtp-Source: APXvYqwizHNDm7V2q4Zl8PfRLV8uyVMUdooEDkuQU8R8qdODhQ4UauaxynjAA3/s6qsYZwd+jj1eJQ==
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr34774771wme.173.1563368895160;
        Wed, 17 Jul 2019 06:08:15 -0700 (PDT)
Received: from [10.43.17.52] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n12sm24739515wmc.24.2019.07.17.06.08.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 06:08:14 -0700 (PDT)
Subject: Re: [RFC PATCH v6 0/1] Add dm verity root hash pkcs7 sig validation.
To:     Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
Cc:     ebiggers@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org,
        Scott Shell <SCOTTSH@microsoft.com>,
        Nazmus Sakib <mdsakib@microsoft.com>, mpatocka@redhat.com
References: <20190701181958.6493-1-jaskarankhurana@linux.microsoft.com>
 <MN2PR21MB12008A962D4DD8662B3614508AF20@MN2PR21MB1200.namprd21.prod.outlook.com>
 <alpine.LRH.2.21.1907121025510.66082@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
 <395efa90-65d8-d832-3e2b-2b8ee3794688@gmail.com>
 <alpine.LRH.2.21.1907161035490.121213@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <bdcd7d7c-92fc-11af-7924-9bd0e184b427@gmail.com>
Date:   Wed, 17 Jul 2019 15:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1907161035490.121213@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 16/07/2019 20:08, Jaskaran Singh Khurana wrote:
>>> Could you please provide feedback on this v6 version.
>>
>> Hi,
>>
>> I am ok with the v6 patch; I think Mike will return to it in 5.4 reviews.
>>
> 
> Thanks for the help and also for reviewing this patch. Could you please 
> add Reviewed-by/Tested-by tag to the patch.

ok, you can add
Tested-and-Reviewed-by: Milan Broz <gmazyland@gmail.com>

or just use the version on my git, I already updated few lines because
of recent kernel changes, mainly the revert of keyring changes, tested patch is here

  https://git.kernel.org/pub/scm/linux/kernel/git/mbroz/linux.git/commit/?h=dm-cryptsetup&id=266f7c9c74b23e4cb2e67ceb813dd707061c1641
...

> The steps and workflow is correct. I will send the cryptsetup changes for 
> review.

ok, I'll probably try to use our existing userspace libcryptsetup API to avoid introducing new calls,
but that is not important for now - the kernel bits must be in the mainline kernel first.

Thanks,
Milan
