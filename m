Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7399D10B534
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 19:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfK0SHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 13:07:49 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:42974 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0SHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:07:48 -0500
Received: by mail-pj1-f65.google.com with SMTP id y21so10365048pjn.9;
        Wed, 27 Nov 2019 10:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XaNcptt5JOTBwtSroj+ydYGlh1N5E9Y6StuuTHLWEXM=;
        b=VTEiRg2St4Tt+V2M3hSqFcn0IYiqpCvoN9uD/5GYp6uejPJKf4EPB6PJ+unmz/Q12Q
         1uHL+vfok43QhrONu/OuG5A+lme2iNOgisRt96yvK12FLHxXKnw+gSaepoD4bG8jL/VI
         j7im10/Wt8R0OcPrQ/v3oEiXEpL/OmSxjEkrNLHS+KuII0MEHGYGWRZHDsJvHr/orzoT
         siEOl/bn6d8DaZOO0BqNAd/tjKKh9EwZVqPOoZ8hAja/k0/940I5P4QGTurKBkUklTbG
         ErA1nwb6gIOODCHzdXLiYnrF9RJX58y9QklfbfBsj4/N2ma0zdaUM3FAJGlfnv5cQeMs
         2sKQ==
X-Gm-Message-State: APjAAAWPlK7pxOQ5vbejFDL/E6k1427+h7NOwo6sNJqz3fCtGUP0us7Y
        N+yBlKepCBQZhinJL1mUbGQ=
X-Google-Smtp-Source: APXvYqzmi1sTtfjlu4oRd+L662PQX3u2Rr0PhWY+LYbbmu8INk3EProl4I+1RiiEHFx3UH+l9R81dw==
X-Received: by 2002:a17:902:7485:: with SMTP id h5mr5458293pll.265.1574878068012;
        Wed, 27 Nov 2019 10:07:48 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z6sm7990456pjd.9.2019.11.27.10.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 10:07:46 -0800 (PST)
Subject: Re: [PATCH] Add prctl support for controlling mem reclaim V4
To:     Mike Christie <mchristi@redhat.com>, linux-api@vger.kernel.org,
        idryomov@gmail.com, mhocko@kernel.org, david@fromorbit.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com
Cc:     Michal Hocko <mhocko@suse.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
References: <20191112001900.9206-1-mchristi@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <24073284-ee53-d22d-dcef-277231283d75@acm.org>
Date:   Wed, 27 Nov 2019 10:07:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112001900.9206-1-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/11/19 4:19 PM, Mike Christie wrote:
> There are several storage drivers like dm-multipath, iscsi, tcmu-runner,
> amd nbd that have userspace components that can run in the IO path. For
> example, iscsi and nbd's userspace deamons may need to recreate a socket
> and/or send IO on it, and dm-multipath's daemon multipathd may need to
> send SG IO or read/write IO to figure out the state of paths and re-set
> them up.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
