Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC40F77F89E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351790AbjHQOTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351840AbjHQOTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:19:09 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB242D76
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:19:08 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58c92a2c52dso20014627b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692281947; x=1692886747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OrbUJMByWo5vPg88+aCkHz5uGYnh9GE5yXXPCqFSCM0=;
        b=Z8j9s4+WBpoIGmYpwI/d0lIOM/JPC8mtB631bXwhWUzXcnQyReerSG3/8FYJ9jAyup
         +3FlXukPc4uN6ptJFldvGPDBB+0Bmv3w30oz4EkJ1ys6XhwHdAV8BW0UJUn5qbokrDH0
         19TsVxOIlmOwBiozW/Kqm4DeoLK19fIDK3IZ3XX4F2uKZhj6pL40WB+qT7RyQg78OvwZ
         WZp4kB3/a6UdCNmXMb2c/vrFailRMNicy61pPKAcJ6E4qJ2undL7ZRilb4ncW2H44hIR
         7XGmFqE3HAet3rQL86kuauL2eSfu4lZk623y+kx6ZcFM+GwbpQfw7fReID0tFpKlw3/N
         Iiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692281947; x=1692886747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrbUJMByWo5vPg88+aCkHz5uGYnh9GE5yXXPCqFSCM0=;
        b=a/Nl31R5Otcr2pXg7q6zLXPOWSbRO3Qp82ECDlcxXmC7KFNXfXKd8j+9oXpaA3IZfd
         sbdDIS9wUWZvyL/PotsB+/SY+tIvTcmimtYqhTUAP9V7HFwW7Jju+fyEjD3/DoDHNgb/
         JscvH6dihzcis56CNdMWcXSYhhsex01r75li8Rou50A0eyU2kKoJCzU7b7fKhEV9o5UQ
         00rExRyvyGsR7Yc8b+FpXec+3y2Vqjon17sVkrcU0K8wSEOIWoKHPseWdOFJO/yYT7/y
         eaQdvy0ah3sFdQ23ppzQZ/dGgRGuDBTntMh+j+7Vo5gTHfcFdfQW+wBhCeSwP9ZAiH8l
         hvwg==
X-Gm-Message-State: AOJu0Yy+J+ZqL2iBvgdVkK+5UPl/S0fngk5my3Hai5zcnrMADorSycMC
        Lufv6ulAxAZzfB7Vq52dQVyDZQ==
X-Google-Smtp-Source: AGHT+IFCvZXcLYvkQo3yXK0be8UsaSh+xObA5AUrn4hww490pN6PdM6Kyd5GqOnNQM2j0ki5WZIiqA==
X-Received: by 2002:a0d:e883:0:b0:586:a684:e7b6 with SMTP id r125-20020a0de883000000b00586a684e7b6mr5067443ywe.9.1692281947267;
        Thu, 17 Aug 2023 07:19:07 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j190-20020a0de0c7000000b00585f60e970esm4643088ywe.134.2023.08.17.07.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:19:06 -0700 (PDT)
Date:   Thu, 17 Aug 2023 10:19:05 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH V2 0/3] Supporting same fsid mounting through a compat_ro
 feature
Message-ID: <20230817141905.GA2933397@perftesting>
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803154453.1488248-1-gpiccoli@igalia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:43:38PM -0300, Guilherme G. Piccoli wrote:
> Hi all, this is the 2nd attempt of supporting same fsid mounting
> on btrfs. V1 is here:
> https://lore.kernel.org/linux-btrfs/20230504170708.787361-1-gpiccoli@igalia.com/
> 
> The mechanism used to achieve that in V2 was a mix between the suggestion
> from JohnS (spoofed fsid) and Qu (a single-dev compat_ro flag) - it is
> still based in the metadata_uuid feature, leveraging that infrastructure
> since it prevents lots of corner cases, like sysfs same-fsid crashes.
> 
> The patches are based on kernel v6.5-rc3 with Anand's metadata_uuid refactor
> part 2 on top of it [0]; the btrfs-progs patch is based on "v6.3.3".
> 
> Comments/suggestions and overall feedback is much appreciated - tnx in advance!
> Cheers,
> 
> Guilherme
> 

In general the concept is fine with me, and the implementation seems reasonable.

With new features we want fstests to accompany them so we know they work
correctly, and we don't accidentally break them in the future.

I'd like to see tests that validate all the behaviors you're trying to
accomplish work as advertised, and that all the failure cases do in fact fail
properly.

Ideally a test that creates a single device fs image and mounts it in multiple
places as would be used in the Steam Deck.

Then a test that tries to add a device to it, replace, etc.  All the cases that
you expect to fail, and validate that they actually fail.

Then any other corner cases you can think of that I haven't thought of.

Make sure these new tests skip appropriately if the btrfs-progs support doesn't
exist, I'd likely throw the fstests into our CI before the code is merged to
make sure it's ready to be tested if/when it is merged.

Thanks,

Josef
