Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30952743FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIVOR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 10:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIVOR2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:17:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E0CC061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:17:28 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so15603039qtv.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lmkHKvhQWDjy+TPo22EHdOgINUlzo9nTiFY5Hb0YDxM=;
        b=B/5nuZLAvXsPd0HbDGqEtCTbRDrbaW+Ahog57XmRWZbdi72gGySJDcZ97+tu1S+iCo
         z38wzWlR1P90JbtFhJsDq6+oa7PXSr3XCqxYhVQe/2dK3JFhDEYitjVCVxjKhQ8o0N8q
         xWKndrOiX3e/0VdNthkK4/2RSW6pQOk8y1NI+VVs9HK4g30LZCJd+WbuyIu5xTqxNghA
         pazukkPmTuEsEFvPmPniv9PR4wNHs/4P2+usRjr/hDkT39h5Yibtvx2TKlmSvI0kvsOl
         d8gXWljBFXMiW7RNRLtWMo2WqvL7no8FtglhFiEnRtYFhwLkJspDdoWbXkDkPoIeJ5mL
         FDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lmkHKvhQWDjy+TPo22EHdOgINUlzo9nTiFY5Hb0YDxM=;
        b=pGpI7LtQfRuENsI4GR3pZ95TFsPdV1doButTIMKXfIeiq/kItMFz6JsIxtPcVtDLF0
         0LzgPUzRXqnzK+/Oidd7n9lybdLgkwuTgj7uIKGieIrIcdSdk1wMhJZBW6xdGGBbdTRK
         l63phAJKFbN6QzWHBldKKFF3famaMuTpNVt3BlzItFmrGm9fpq2rdryTOxFHnOTOx2MI
         86yXUxXF8XLJ/MpHrT8SCezwY/Ddmzu2Ibpcr7fKXkvqmoo7rvPfhUPIic3YkRsQkniM
         cq2lfZThALCP2tk1RFejA851Gg0l5mw8gufRO2N6UGnWTBqa/jgyFW5VSafCAKlarHlb
         bRtA==
X-Gm-Message-State: AOAM5329P7CP7okuQlfSuvG0DX4aS5f1aYOoTRy+44zyoeXgeLfho9P8
        RZGgwYiuW0gT1rRKjXD4YZ3TpA==
X-Google-Smtp-Source: ABdhPJw5TArAbezCs6y4WdY7u+7Q0dIOg4VjIbajRbOzmLSW19Gzpk9ulisDTEP/g/y6n6lJWIh5nw==
X-Received: by 2002:ac8:33ec:: with SMTP id d41mr4933258qtb.390.1600784247688;
        Tue, 22 Sep 2020 07:17:27 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p3sm11561735qkj.113.2020.09.22.07.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:17:27 -0700 (PDT)
Subject: Re: [PATCH 02/15] btrfs: remove BTRFS_INODE_READDIO_NEED_LOCK
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-3-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1ba34100-4c3d-2fd6-528b-a16efedeee25@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:17:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-3-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Since we now perform direct reads using i_rwsem, we can remove this
> inode flag used to co-ordinate unlocked reads.
> 
> The truncate call takes i_rwsem. This means it is correctly synchronized
> with concurrent direct reads.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <jth@kernel.org>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
