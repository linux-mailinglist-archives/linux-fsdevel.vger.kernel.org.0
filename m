Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D12E43857
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbfFMPFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:05:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36226 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732462AbfFMORK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:17:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id p15so3333747qtl.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IdWKzce3sZz9+VK0mMGhceU7W1z4LrhQkC1c9OeYugc=;
        b=oP6ERCa1F6T8r6pSHlZINu6LknBTF+UPLpwmpRJcH+T6FdeYawjrBm7oQ0iaSVxmjD
         LZmwbZomBs1w1G2Z2uECjOVu4ctdMmjAbGswoZajXSueNHfNEi2kDdbB0eo5K/L6TPX7
         gZDgT2bbG1XJxfKdQTmNc/rRjKzTRncWVcJVin9R+eQOLHXhMw81x04KLiHKKskUszQf
         ZBhBJw5X9u7/w7EZhQAiKlEqEZsI6T8SkRldzr2n/0VkSPQGDovwNcD8pbdF8P8kD9fH
         yrx5FvRP/YCxnPdJUo/PdMnD9HHxHisaI1pK2EJyShl5GyzSbTt0LN5tNALrEQUHkLxB
         Gsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IdWKzce3sZz9+VK0mMGhceU7W1z4LrhQkC1c9OeYugc=;
        b=pp3EsCJAo0/7LzaH2V+DskIDSce0Fg1jNb2wT6onUpZl0GkQF+AQmgYGVqoJCVyNmH
         iyz222NWYnU2EvDJ9IwfXCrLCWivdKHrTl5COWN2xhtpTIZMG+k+vr4Hv8WS+CohRDNB
         nnAgTBK3AZF+cTQAsbw+S2tjJe0BCcppQZW+FjAOPlePvoDHblUO9C91Dc8OBYSV6tHi
         ON8LHxR5iEM+WH8xlpQy+WHgO2LP94HZDd7dhm+oTMT5nds90Yh55kZ7BVAVRbl0y3nH
         PadrineFF/44GkUSQXgEoFKWNOTEz9dLADYg+aX6zUkhlQ9UztYsb5D86GgcMs7wAJxL
         aLvA==
X-Gm-Message-State: APjAAAX4+vTrOWW3hzxNrCa/EtVsFxBrG1jA+MdkbN8TrVMg4jNKYTAh
        AkNxZMSdU1XrQ0zaShHwlJ9Q7Q==
X-Google-Smtp-Source: APXvYqx5jPsVPa9dGQd9Bui4/XGgLT6BOzvijxJlMoqU0XvFjHiv3oPKH2im4jOl3Wj+44uE9UzG2A==
X-Received: by 2002:ac8:25dd:: with SMTP id f29mr66160028qtf.144.1560435429256;
        Thu, 13 Jun 2019 07:17:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id 102sm1338356qte.52.2019.06.13.07.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:17:09 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:17:07 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 13/19] btrfs: avoid sync IO prioritization on checksum in
 HMZONED mode
Message-ID: <20190613141706.tbxc5wufplfybfib@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-14-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-14-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:19PM +0900, Naohiro Aota wrote:
> Btrfs prioritize sync I/Os to be handled by async checksum worker earlier.
> As a result, checksumming sync I/Os to larger logical extent address can
> finish faster than checksumming non-sync I/Os to smaller logical extent
> address.
> 
> Since we have upper limit of number of checksum worker, it is possible that
> sync I/Os to wait forever for non-starting checksum of I/Os for smaller
> address.
> 
> This situation can be reproduced by e.g. fstests btrfs/073.
> 
> To avoid such disordering, disable sync IO prioritization for now. Note
> that sync I/Os anyway must wait for I/Os to smaller address to finish. So,
> actually prioritization have no benefit in HMZONED mode.
> 

This stuff is going away once we finish the io.weight work anyway, I wouldn't
worry about this.  Thanks,

Josef
