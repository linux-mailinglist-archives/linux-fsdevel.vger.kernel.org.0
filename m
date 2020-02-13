Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCD515C80F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 17:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgBMQRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 11:17:55 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38760 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgBMQRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:17:54 -0500
Received: by mail-qv1-f68.google.com with SMTP id g6so2870679qvy.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=szNWZ8nZIP9VqzjWfo1padC4dW5ZLKPqhH+3QbR9kl8=;
        b=j9UNLAwB8efOOKnRVo8/347tTQ6Emo0KZLDuFkI/NfeB6/r7/kfh0s56f8K2fjDd2P
         G0vDCCSUm8BYT/j+eXFHCbnElD1URx1QXqbdAPU1ahKgjFwZuQPFuu28qpAtFsnAnA6B
         zF+Cp1O+FpbWDUMyU4kyY3p3gFKaIAwFEoHtqmEY0QQ6oIApksC9RtvejC3zvq6aLBuM
         RQvdPtyj1dptfIt91qUGWHLJrGgYq8UkhmdRL8epPcYf0vieBEDSK5Erm3Y62ZxU9wfj
         l7VsEAjb8b+sVW85cYmdPWA2z5pMfSqZFGbYRTlDsPv90ghNgie1UJkK+05DqLFx4QWo
         RvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szNWZ8nZIP9VqzjWfo1padC4dW5ZLKPqhH+3QbR9kl8=;
        b=mwIdYimhJV3p+RLHpKRcLXP0ScVfup2xCWxDrJWVW/dFQd3od4obuEwJ25lJLgWjDe
         3bBlBHQ5fV7io3umfI2lPKpbQrXr7My/i7LfLRJrqa4jW5IFh65bpByXfhPr2Fqnw35P
         PH5LRAzpKOYo9mNpHROnpMhgXxeT/JochppWwtHy3hDXgb5MIbNAmNC6TupUPDfEYWf3
         gEm9czB0+CblNonahVmRAvql/z0Q3TPNkXTKZG+jDIitLahst8L5u7qg76PQlZiAcaZk
         tt12SML+k8+szoNrBGmFkBlgezzEkZtXHBQQUdeAq2dsDZfhCz3HwHcZKTS3Mhm0jHd0
         n3Hg==
X-Gm-Message-State: APjAAAUy0YzBWHMrblqavUs1rZTawAG1Az9SVDHT3Oh/RJVh30dAiLei
        +bKb0sR3dZPNqW1hJ6o5qXVA1y7qXdg=
X-Google-Smtp-Source: APXvYqyhZ4YRD5YkR/framUUFq+P/Onh5045Ye4U5HO1QXpXQ4v+dlntPSiOqGYjMh0mf9shH9NbfA==
X-Received: by 2002:a05:6214:4f0:: with SMTP id cl16mr12342474qvb.213.1581610673364;
        Thu, 13 Feb 2020 08:17:53 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::edcc])
        by smtp.gmail.com with ESMTPSA id b12sm1566485qkl.0.2020.02.13.08.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 08:17:52 -0800 (PST)
Subject: Re: [PATCH v2 05/21] btrfs: introduce alloc_chunk_ctl
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-6-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <64b1ceac-b254-ce1e-6d6e-f75fc4929e12@toxicpanda.com>
Date:   Thu, 13 Feb 2020 11:17:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-6-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Introduce "struct alloc_chunk_ctl" to wrap needed parameters for the chunk
> allocation.  This will be used to split __btrfs_alloc_chunk() into smaller
> functions.
> 
> This commit folds a number of local variables in __btrfs_alloc_chunk() into
> one "struct alloc_chunk_ctl ctl". There is no functional change.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
