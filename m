Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A18F8123921
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfLQWJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:09:08 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42071 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfLQWJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:09:08 -0500
Received: by mail-qv1-f66.google.com with SMTP id dc14so3194156qvb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 14:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4v7+/P0di5/r1uiCUQtF1sNSRcFmNskc3j4q/dPKlDI=;
        b=SjUvFyA6UVyEvZy+bpI6ri90XxUsHhGhF6DKbDuLHRD8I+FBFVli2AEthOKuePeeIm
         3tf7mG6HfPbxyRuzcmkg0J8+jsYhQvsN11uPgySiQsF2EFPgoJNXQW9QOmJXUZkmtUcx
         MLwu7DH4G88lapUsp4db1yTHqqaWKp9Vt8/I3oj+XNNrOHFWDR3Gln4GMKqt9uj41kW1
         9GueC4wUVM0JCXFTgA0WhCewKOqgRF+YJvUfWvThNIxmgGwG8pIdiFUaU7RVGFMr3CUB
         ijKdLTKvzHerkCp6PGYK3yeNChn2N0sdvTD8Ard9IFURtOfoJzKPdMf/wBjB0ANNaI7q
         Bgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4v7+/P0di5/r1uiCUQtF1sNSRcFmNskc3j4q/dPKlDI=;
        b=AuzLGI/8+WLhX33ero+LEPwoH9Yot1aDZ+QGdPwhN4Su68VGopdsqggtqXapa+2xYi
         qHTj25kiHXBhPAVAMxTS9Xfjn2vM8o/1g4hC7n4F6aG7iUcfz34JrOPSvO+loNI5f0//
         FwP6HNSXULGKn8N9vKEASjzWMZAai7NW4aYVOhvGLN9FFoZd6VkUeuSEXJ47S/2TXbS4
         1cUJXBZuoIWu9DW6NR6/xLn6m85CTn0jDGTn3DMpVii3XTNtmzbW+KeDXfv8TjYr7ZHp
         XQlMj1UfTATPZI3XrYa9EtLYxAarbr+tAjfUG1kW+9HkeiJ99aljDQaOeommF76JGLMA
         sbRA==
X-Gm-Message-State: APjAAAWn4nlgBhbqefOuymiJ9S7r81A8exTAos7sN2Z5rdcCdj/qPxl/
        gERMOHMamBdgG4AQFOmMrBjAs8qtSjJncA==
X-Google-Smtp-Source: APXvYqwGd+cIax2eNewDpjkqNCfbxd9/3dnBDetFM+dhBp69lYuipITvPvtwGdNZDj+WQJ3jZ9UvMg==
X-Received: by 2002:ad4:496f:: with SMTP id p15mr6827249qvy.191.1576620546928;
        Tue, 17 Dec 2019 14:09:06 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u4sm7474376qkh.59.2019.12.17.14.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 14:09:06 -0800 (PST)
Subject: Re: [PATCH v6 28/28] btrfs: enable to mount HMZONED incompat flag
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-29-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a2e12d52-5894-5b50-5a34-d7f3858b363d@toxicpanda.com>
Date:   Tue, 17 Dec 2019 17:09:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-29-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:09 PM, Naohiro Aota wrote:
> This final patch adds the HMZONED incompat flag to
> BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount HMZONED flagged file
> system.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
