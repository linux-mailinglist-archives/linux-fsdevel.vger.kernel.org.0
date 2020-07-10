Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF0021B048
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 09:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgGJHgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 03:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgGJHgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:36:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE6BC08C5CE;
        Fri, 10 Jul 2020 00:36:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j20so2178863pfe.5;
        Fri, 10 Jul 2020 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NM9hRQGVmM2KH57czf+cUvfrBg86usymDmJIKhKEYgM=;
        b=eZGGOR7ZVaigjgbJclFyHN0F/VhWL9EygwYYc9ZO2J/2Izwem1fTge3L1diTbU+Eld
         QWrx+JK3GAQfaVUSPce13UetdFOqn2KPE9RtMLqKKUlS0Z6ixeDl3GeYlLtP1NXVuD34
         /oZNkiO1cQJSbYn5eF1H2c1kWb1SGi+Dh1wp8pX1IAEccLmK7vCpRx8qVSZSwuB5tXEC
         e1txj+6eor5B7RL9TDzgMN6FpSGuHSRxs6mz75kq787Zh3yypyN7gpyZCXOSoGyzXE0J
         DWL3AY3+C+QmWtSXsBRI3xX9GD5EILlDcGFn+922jRudn1EEOVeLvnNjO+5i5kokYxE1
         q4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NM9hRQGVmM2KH57czf+cUvfrBg86usymDmJIKhKEYgM=;
        b=nK+nTXKfYOElq0KiYLyh1UUWXYtdE0LdpRhpG7E9i4LeV005t49ZhoeQ09QolXV5kC
         eYcwEpBKdJmGrW0cB5GYcxj/FCil9NH7OHuALLe4d9BKgDroIXQTPZugWWL3eqRsJ4eq
         UVN00QrUlUHJeAkAVZTbUUdZ3lVEiOw16Lh7l0k0VO41pBb3AofJ5P+7G1UNjcx0OhH6
         x6AOAV+rV9FOH1f8GGctKeuQ0pjtGTzsGmvJ2R5cIpqoNM/JcoL/27+ycmkMkJokg2XX
         Rk+bFPWDsikl1xk/mOezidi8+3voHFhQNgoOLm3GHw5qksdiIEDUP+heZktmByRlEHyM
         ALHA==
X-Gm-Message-State: AOAM530mxmX4TQbTxSh3oL9dFhvn960ByIbMiPSEB2KmUHUcfWE+1FqQ
        LvB435k3e4VS1jhj3ueJVd/rk0rNHkw=
X-Google-Smtp-Source: ABdhPJwe0R0GKlWFwac2Ns3qmXDFd/JKf0uMtjQmUv9gUg+9pDN8VJvz8l6PEc4AkAb215SXoi+zoA==
X-Received: by 2002:a63:1b4b:: with SMTP id b11mr55704044pgm.243.1594366598873;
        Fri, 10 Jul 2020 00:36:38 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:fc6b:54b0:c37:7155? ([2404:7a87:83e0:f800:fc6b:54b0:c37:7155])
        by smtp.gmail.com with ESMTPSA id i128sm5158752pfe.74.2020.07.10.00.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 00:36:38 -0700 (PDT)
Subject: Re: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3@epcas1p2.samsung.com>
 <20200616021808.5222-1-kohada.t2@gmail.com>
 <414101d64477$ccb661f0$662325d0$@samsung.com>
 <aac9d6c7-1d62-a85d-9bcb-d3c0ddc8fcd6@gmail.com>
 <500801d64572$0bdd2940$23977bc0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <c635e965-6b78-436a-3959-e4777e1732c1@gmail.com>
Date:   Fri, 10 Jul 2020 16:36:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <500801d64572$0bdd2940$23977bc0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2020/06/18 22:11, Sungjong Seo wrote:
>> BTW
>> Even with this patch applied,  VOL_DIRTY remains until synced in the above
>> case.
>> It's not  easy to reproduce as rmdir, but I'll try to fix it in the future.
> 
> I think it's not a problem not to clear VOL_DIRTY under real errors,
> because VOL_DIRTY is just like a hint to note that write was not finished clearly.
> 
> If you mean there are more situation like ENOTEMPTY you mentioned,
> please make new patch to fix them.


When should VOL_DIRTY be cleared?

The current behavior is ...

Case of  mkdir, rmdir, rename:
   - set VOL_DIRTY before operation
   - set VOL_CLEAN after operating.
In async mode, it is actually written to the media after 30 seconds.

Case of  cp, touch:
   - set VOL_DIRTY before operation
   - however, VOL_CLEAN is not called in this context.
VOL_CLEAN will call by sync_fs or unmount.

I added VOL_CLEAN in last of __exfat_write_inode() and exfat_map_cluster().
As a result, VOL_DIRTY is cleared with cp and touch.
However, when copying a many files ...
  - Async mode: VOL_DIRTY is written to the media twice every 30 seconds.
  - Sync mode: Of course,  VOL_DIRTY and VOL_CLEAN to the media for each file.

Frequent writing VOL_DIRTY and VOL_CLEAN  increases the risk of boot-sector curruption.
If the boot-sector corrupted, it causes the following serious problems  on some OSs.
  - misjudge as unformatted
  - can't judge as exfat
  - can't repair

I want to minimize boot sector writes, to reduce these risk.

I looked vfat/udf implementation, which manages similar dirty information on linux,
and found that they ware mark-dirty at mount and cleared at unmount.

Here are some ways to clear VOL_DIRTY.

(A) VOL_CLEAN after every write operation.
   :-) Ejectable at any time after a write operation.
   :-( Many times write to Boot-sector.

(B) dirty at mount, clear at unmount (same as vfat/udf)
   :-) Write to boot-sector twice.
   :-( It remains dirty unless unmounted.
   :-( Write to boot-sector even if there is no write operation.　

(C) dirty on first write operation, clear on unmount
   :-) Writing to boot-sector is minimal.
   :-) Will not write to the boot-sector if there is no write operation.
   :-( It remains dirty unless unmounted.

(D) dirty on first write operation,  clear on sync-fs/unmount
  :-) Writing to boot-sector can be reduced.
  :-) Will not write to the boot-sector if there is no write operation.
  :-) sync-fs makes it clean and ejectable immidiately.
  :-( It remains dirty unless sync-fs or unmount.
  :-( Frequent sync-fs will  increases writes to boot-sector.

I think it should be (C) or(D).
What do you think?



BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
