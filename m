Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5382115CB86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgBMT6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:58:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42061 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgBMT6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:58:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id e8so2753849plt.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 11:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xgCpLPvq+/Skqydk14WwtiDwsgHBRzQseVT6ExBn8eQ=;
        b=tXT3ZelwUz+24PZy/McJhhKAuxaQsyR7Bv4oJm0VgXdER5AvoEOJ897sCUSLAqGIjk
         s7F18nL2HlwRV85vuomadNxVAJqR468E44HZSaZY5MHaYzG/bsbltZq+pNrF6SkfvdIl
         fiqPpJ5vtY94KrGFVvwQjI+NhtvNKZBnSVNeEAS5rXP0bY/tVmFQH2qQKP4l+QFVb9Ka
         XryYzlsKx1fv18z6q/3Ol4SAB6ZcCG89JtfxqDww+nJF1wZASLyzxJ5sCpp1ZJiM6KRX
         IKmPWd4+FOkhcpyw1UBb38rX0qBuqP4UH3aTzFEFjJJEzx+t5pgE/H2aJUQFht/2llE2
         82XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xgCpLPvq+/Skqydk14WwtiDwsgHBRzQseVT6ExBn8eQ=;
        b=lFjpowNu6ZIi9xdt82Nc8EDmNdjb9PhYDTUuapSqgDaXaOCfEi5DK/hQCZecEYoPRK
         0fL50HUvN+76Ear/ZdKK2bPWHqvzLhLoXXVhf+W+uY8oXgvlcAoLqOxYpPVYo/M5q8Lq
         D5+aX3sckfaM38jcowYC2nsBX3H/BXDP7pHDdPpkcIvKTSFxOA9AVnZmQCtEslt55KtK
         ROk1cAHtHtJ5HijmsdMR1Dmq4jFG96cz1D2V0mUe+ZXzVX/qvqjW2DaLr62frvdQXols
         BU2QkOR0rPycZNstwlNghXYNXCWB9/0RTMioIMTvhOoFtRqT6mlSt8/TS6rPXR7fkFIY
         N+Vg==
X-Gm-Message-State: APjAAAWYNLGX3NlnpOgnw15478iBHiykTKi3KH8HxYfoyafAx5h+elGt
        vjDK3jlKTkRn/FJn69k3yg9VdjidNik=
X-Google-Smtp-Source: APXvYqxVB12lO5pX915XlAGi+n7cjCFSIFy9ZW2QOZfQTGGRoBK05/lt4gW3Lbgfrk0VEClzPt3VrA==
X-Received: by 2002:a17:902:7c88:: with SMTP id y8mr15353794pll.321.1581623891291;
        Thu, 13 Feb 2020 11:58:11 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id j21sm3554146pji.13.2020.02.13.11.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:58:10 -0800 (PST)
Subject: Re: [PATCH v2 15/21] btrfs: drop unnecessary arguments from clustered
 allocation functions
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-16-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d5376f5a-6a1e-fa3a-2a71-80d199c93e7b@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:58:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-16-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Now that, find_free_extent_clustered() and find_free_extent_unclustered()
> can access "last_ptr" from the "clustered" variable. So, we can drop it
> from the arguments.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
