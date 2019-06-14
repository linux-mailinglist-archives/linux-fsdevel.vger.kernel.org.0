Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470DC460A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 16:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfFNOZj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 10:25:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46489 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfFNOZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:25:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so2719665wrw.13;
        Fri, 14 Jun 2019 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1Xht2wc6GWx7rzL95f/p5mApKK3FegYBNbBLdEdfnr8=;
        b=HTTzFtfpAF7+upWVnlS6HBVNxdNCAADrxhNr4kucftYM4HXyFdAvdhyZxI+VeHwMml
         tpCWY6gmJD8HUgbBkc+253BCWQZ+EKwBarLVFbmzugu1hsPor4xw7UaSuB3fX50ahyeF
         98A/bSytV5+rUoSWDjrvwqlHAyARUmOvVB1TopUb9S1Oe3HfKH+eCnuiCLhkLzp4aT2Y
         f3SJIwUVEaHqrNeDpwUTycBzlA2luKc9RKu+ct38kupUocELFqB8akHFXXMH0TyT0S1R
         DHre7T8ydHY4mLa3ZSteGpRlTAyWh9QS9ibS3245dY+bIiC8yk16FwhWl8lq9BDkeRYh
         /MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1Xht2wc6GWx7rzL95f/p5mApKK3FegYBNbBLdEdfnr8=;
        b=P0LsrmlvEtCY+2LPOikfguIHNDfeM9nZOelgwefKTWTk7NInK9MOVS7FqF2a6F94Hh
         1q2MT2V/jS+NUn9EietTKRSx9Jzgb4Sfc+eezv0VU9S00maAZDgs2YdoC+QZktX25Vl6
         q2XZxwoecaMWy/SMys/eTymUYgEeddvj1Dm4fHzET2IB1GmiBl1mAsFS2fDvwwgFRSiH
         2L3P3lA7v5B8w+2cQ0aXy5z7wYIbH3hJuXWuU3UflmGADyIWKrcms7QD30ySndociFm6
         cpvFzTf1xIjFpBZ0wglcmk3smGqmJmx0KFy3QXEH6psDhkHdB/d5X25eQxwIvk6lWtQJ
         +gVQ==
X-Gm-Message-State: APjAAAVNXfNMtN4o8Vo6pb62HSrnpyrr1c4V+ygO+7u0qNzvwFgqEduo
        80W3XQmDvoMYiU/QR2h1PyrkEwqEw/Q=
X-Google-Smtp-Source: APXvYqzwEPtYyUzAXb5zFSOaN+f0YKpZ4EqTXQYjc8hxuUV7sIsNkAI1Sk65ytkZJVM7eEj1ESqcLA==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr3408593wrn.222.1560522336433;
        Fri, 14 Jun 2019 07:25:36 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z14sm7966501wre.96.2019.06.14.07.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 07:25:35 -0700 (PDT)
Date:   Fri, 14 Jun 2019 16:25:34 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     util-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Help with reviewing dosfstools patches
Message-ID: <20190614142534.4obcytnq4v3ejdni@pali>
References: <20190614102513.4uwsu2wkigg3pimq@pali>
 <ae5097ee-12af-2807-d48c-4274b4fc856d@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae5097ee-12af-2807-d48c-4274b4fc856d@metux.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 14 June 2019 16:20:08 Enrico Weigelt, metux IT consult wrote:
> On 14.06.19 12:25, Pali Rohár wrote:
> > Hello!
> > 
> > Can somebody help with reviewing existing patches / pull requests for
> > dosfstools project? https://github.com/dosfstools/dosfstools/pulls
> 
> I'll have a look at it. Could you perhaps prepare a (rebased) patch
> queue ?
> 
> Does the project already have a maillist ?

No, there is no mailing list. Basically whole development is on github
via github pull requests where are also put review comments and where is
also whole discussion, including bug reports.

-- 
Pali Rohár
pali.rohar@gmail.com
