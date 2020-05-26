Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654111E25D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgEZPpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 11:45:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29580 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728166AbgEZPpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 11:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590507922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dt6LQHnd8XQKjoczzuKu5+J73yx/PTFTJmXrE029Qj0=;
        b=MuDE1EeNGCQ7ZtyasjHIeRquVoyGlw4ms/cF48n+wazvpvZJXtfMaHWohfbEpb6eu/b5pd
        cagcXwYz82p5Nr22SwvYHKapCY9bDujsdyxeL5jbNE0kD6wB2awofKGhTvYwW4Qc8IF3qm
        sR+IEuKfj/j1E+CuQh5LmGbRLqBM3+E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71--cN4ttcmOEW9jeqlajlLWA-1; Tue, 26 May 2020 11:45:20 -0400
X-MC-Unique: -cN4ttcmOEW9jeqlajlLWA-1
Received: by mail-wr1-f70.google.com with SMTP id h92so5680639wrh.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 08:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dt6LQHnd8XQKjoczzuKu5+J73yx/PTFTJmXrE029Qj0=;
        b=Hm7yyxcvJxDfZL1vGdMy+tmUBu7DDxtXDLrCsroFYvtT5sXQB6BmjO9zzm/LTPXio6
         4e562PZYdm8ucE8vz1otITV9gOl9WV90qx1SgdROAiLvTOezpZ43NOHOZXuEO1ESDIRi
         sqIQRhOv3ck/HivGxD6jrnTGSgoa8RpbNTfz+YUl3ZGtYt04HewQ2AXmWVhGRmOX05xB
         1Pj95exV+OO1cqZ2Q2A0i9dmxPa6zGZwidf4KB6CBZbeQqvEOQ5kDu2Oo7Q14Cwp6iYm
         yyAs7xD+F/86kFQZpGBwi43tnT/Zm1mp4pAkDXuG4z9HWtid+cq5yvATr9I0lcJFMOqb
         EOTQ==
X-Gm-Message-State: AOAM533TrE85Er3vrHwUEV/wtt5UFVG3fWHnT3JAXXXGKmfZG1CO9F5b
        mWRachfgtpTUjxZ0a9Olz3wH9TRFhJovMc1wz/ugPQl2jhKccWoOD5HORxHAv1T5p2QWHHa7ccE
        FSbq2EVU3ddAMKz8ElTxamwgA8g==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr2590857wrx.231.1590507919724;
        Tue, 26 May 2020 08:45:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5If1uNgTKWEisUAJowYTPwcuzMOOow4nahat1ESbDjPkHGjhZwTTbQrIPi02UQ5LtAAq4hw==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr2590848wrx.231.1590507919516;
        Tue, 26 May 2020 08:45:19 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.118])
        by smtp.gmail.com with ESMTPSA id u10sm32544wmc.31.2020.05.26.08.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 08:45:18 -0700 (PDT)
Subject: Re: [PATCH v3 7/7] [not for merge] netstats: example use of stats_fs
 API
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
References: <20200526110318.69006-1-eesposit@redhat.com>
 <20200526110318.69006-8-eesposit@redhat.com>
 <20200526141605.GJ768009@lunn.ch>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <99217496-929f-ed3b-8e9e-bbd26d06e234@redhat.com>
Date:   Tue, 26 May 2020 17:45:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526141605.GJ768009@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Andrew

> How do you atomically get and display a group of statistics?
> 
> If you look at how the netlink socket works, you will see code like:
> 
>                  do {
>                          start = u64_stats_fetch_begin_irq(&cpu_stats->syncp);
>                          rx_packets = cpu_stats->rx_packets;
>                          rx_bytes = cpu_stats->rx_bytes;
> 			....
>                  } while (u64_stats_fetch_retry_irq(&cpu_stats->syncp, start));
> 
> It will ensure that rx_packets and rx_bytes are consistent with each
> other. If the value of the sequence counter changes while inside the
> loop, the loop so repeated until it does not change.
> 
> In general, hardware counters in NICs are the same.  You tell it to
> take a snapshot of the statistics counters, and then read them all
> back, to give a consistent view across all the statistics.
> 
> I've not looked at this new code in detail, but it looks like you have
> one file per statistic, and assume each statistic is independent of
> every other statistic. This independence can limit how you use the
> values, particularly when debugging. The netlink interface we use does
> not have this limitation.

You're right, statistics are treated independently so what you describe 
is currently not supported.

In KVM the utilization is more qualitative, so there isn't such problem.
But as long as the interface is based on file access, the possibility of 
snapshotting might not be useful; however, it could still be considered 
to be added later together with the binary access.

Jonathan, how is your metricfs handling this case?

Thank you,
Emanuele

