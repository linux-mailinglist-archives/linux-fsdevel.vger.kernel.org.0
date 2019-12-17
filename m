Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1D1235C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 20:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfLQTdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 14:33:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36801 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfLQTdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:33:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so8252114qkc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 11:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EK16g3nUco063ej0O/BC/spw4fg99/8/32wGo+b7saE=;
        b=TQ3hjYhjrGEDedL07c2Z63vTbFqVSYFU5QxaPf5fcid3ygZuk3lDoskGq6AeeCDWTi
         Sq7DP2CmsE/ewCmT84ItW1bIHPretCak9Ph4YFt3CWJrkCBhPsI/A28F0s2IIErU9Fgc
         gRfkyNA1otoRju3bnzwY76firCHpbTVVdBx54XPNH0y5lKJf8RoaCSs9RxrfM39HUpYB
         PvS8uJfF93NlfYABPHRhMcxxt1EOTHFZmWG9XLB2JnG1fqxCpHnvs5MRGivUfxJJUiTM
         mc5qj2mYjNlUU2znQ4QOoQ5wCt8KzbMkfF4TWoaDA0hJpSKEW1Nri9G2JidUXl3zS8tM
         FNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EK16g3nUco063ej0O/BC/spw4fg99/8/32wGo+b7saE=;
        b=E3KXmP48C9smndpBZcNx5BYNyOqtqa8wT23BqNQ68cJBTi79rStDRzIQ/KxeYsoo0k
         QvhW1+W3eXd8uJxlH6KTq5q0THFts64RxGB/7ACZR1hQz70I99ABr+GTjt6O+NsGldU8
         J4b+G+ZLnYKjZNYMKbZCsHS+buQ+qCabd3CCZUaHE4GWu79oB5+WlPWmlsX3++nV3U/j
         Yrjd2UoYUc9Z2ARg23nV9oKoigPwHclo5YXWFEZc4jywXFl9Kgyy4Tg2AXbo0AzLw22l
         RSKlFFv5X2zbL902RqLFDgi7yplvs7R7StlJUaWLdKd4S840PrioCebA8uVagzWLMKhd
         ZINA==
X-Gm-Message-State: APjAAAXYUPUUgjvTyGSEjey9E9E9/EQFO4b8YB7mnx8OrYWDqxxMZeM0
        MdMG4AFmqYie/zuP5bE4DGZkFv1wI3XdGA==
X-Google-Smtp-Source: APXvYqzgqQC6OfWmPeZu3mxEl5IgaCYiEYPOjpb9WJ9RNANKj1L42lA+xpK6lYwQc4s92XOQdNasuw==
X-Received: by 2002:a37:354:: with SMTP id 81mr3057845qkd.276.1576611228868;
        Tue, 17 Dec 2019 11:33:48 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id i5sm1065924qtv.80.2019.12.17.11.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:33:48 -0800 (PST)
Subject: Re: [PATCH v6 13/28] btrfs: reset zones of unused block groups
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-14-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <75f4144f-6e2b-ea11-f4cd-a749e16d2696@toxicpanda.com>
Date:   Tue, 17 Dec 2019 14:33:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-14-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:09 PM, Naohiro Aota wrote:
> For an HMZONED volume, a block group maps to a zone of the device. For
> deleted unused block groups, the zone of the block group can be reset to
> rewind the zone write pointer at the start of the zone.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

But Dennis's async discard stuff is going in, so you may need to rebase onto 
that and see how that affects this patch.  Thanks,

Josef
