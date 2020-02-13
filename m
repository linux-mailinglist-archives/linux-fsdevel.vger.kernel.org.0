Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF915CB8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbgBMT6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:58:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36453 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgBMT6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:58:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so3689811pgu.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 11:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ESEGPLBxVfjT2kBbKoKoz+3Z+VqmDzjIaUh0PzYp5rM=;
        b=y2pd4cE1bet5nOBxAp+qAE6BJxDuEjgRHGjRfFejbIF4uFlzZu3/ewT/SY+lNL4n5P
         kbprtILOpHxOiXA7Nr5a/CW6a3Ga2Klnbto5Y8Hkhn1mhtIipDij6HAwyYeb5VER32cz
         xVlbbGf2p0I2PLtXknnsOgB//PXTPO+fFQ99IhHMY1z87FzyZywxGHy7SwLFxZNLpiF9
         qZdj186XQ126uMQsRXnV68vOD4TvDtuLaGvzBsicjR5VqJVq+mPlRc9OtTbwW/N3EUBq
         CxXHO0Vf8aE1dEaTAIBBdByMPWNXP+rmh/9A5YAq1qpvC+kxp3nyHtCmII+y09L3Pn5h
         e7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ESEGPLBxVfjT2kBbKoKoz+3Z+VqmDzjIaUh0PzYp5rM=;
        b=R3KOdFlb9ysafK+seTGTCPvGWmtF6tckIxoW3wCGVdE7mhNrF8S0yDdrTYnxTRjmJm
         d9FX01o0LbsXAn9XJTgLxYZkixlE6yjZMZl2daIyLkZI+Ul04R7pwedkIFbv9XPZrnoi
         jFs80b9686LQi7Zc3FWIjudcwOWQS97c4c1dWhzDmJ8PqWqLcpztzvsineu7U3ViUgja
         3Lugekr7r9lCyIggeTdUkHj0TRvIYVLjkDYnYeNhNM2XNSXlkTRelA9e2VcLueidjk/H
         AI5+4qEsrLfZUw9DOI5w1x34aRfY2ElsuAPNdrYxu7ZhpsjTa9om7Cxk8xoyBTQiP+rs
         yu5A==
X-Gm-Message-State: APjAAAXwa1JxTGso7vYEUaVzfhMdnIuMAI6XemdQa+oVSF+FmqlK7QKv
        JiOEOjYE8RrFi+mnHgI4n0Ad0Gx3Qpc=
X-Google-Smtp-Source: APXvYqzG/7bQWYFe6byNlvMQXDFoL0OfgFR1CfDQTHtvAFLkJ6pLEQXQNxjVnJI7PLiCKveEVV/K6A==
X-Received: by 2002:a63:9dcd:: with SMTP id i196mr19443489pgd.93.1581623933377;
        Thu, 13 Feb 2020 11:58:53 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id z30sm4313411pfq.154.2020.02.13.11.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:58:52 -0800 (PST)
Subject: Re: [PATCH v2 18/21] btrfs: drop unnecessary arguments from
 find_free_extent_update_loop()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-19-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <04796698-dbd7-4d7c-eec0-1ea5ecf90804@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:58:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-19-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Now that, we don't use last_ptr and use_cluster in the function. Drop these
> arguments from it.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
