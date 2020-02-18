Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDB5161E4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 01:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgBRA5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 19:57:53 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39253 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgBRA5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 19:57:53 -0500
Received: by mail-qv1-f67.google.com with SMTP id y8so8417718qvk.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 16:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3gvQ0sM3ytTu/Qcw9VB77NLK9qhfuJCSYga8WjMrsYc=;
        b=UUEsdNGKIQC+ngw2WvCHDESp6QeS0vjjDXi/NltUzlaI/jkVT6YR1BfD2ktbi/DXT6
         cvAWA8KAgNqw3p7wvX2GfwMMk+jfXy9E6JDoTfzWiTi3V9Buhpolmy3D2SdJCXu5ygPv
         xT9FnmT7e8wUrgUEmujdGOWixOCDXwkAjwoJy15WXUE52DSJ9X4wym3q4DRejd1LH/oo
         UE1721PJ2Ds6iIuyBkRm8wSLm3Nu+EUk/IM/kIoFMzLMcBB7zQjxiRTRjBGXVNumiapw
         OFQwa6nhDyvb9Ldh6aZpg4Fs2fahD0zWilmyePA5eclI6l4UX7hUQGBH+QDlO5NQBVEL
         6i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3gvQ0sM3ytTu/Qcw9VB77NLK9qhfuJCSYga8WjMrsYc=;
        b=l0yKfVhee+aPfOAmBpMgC33SXtUqL4Yvcr0GVVmMvPPh3fqzWwrw7CpWs6H5mE3t1b
         kb8g476hUiTUL/X+grJKzqjdFOtkWKHKszMlrYOFbteCipU+c1ViOLl9mBf8u+HnPcqt
         Pdv6Gdsd9CcN49ahvp+R4cRHvJZCBVqH0XCQNu/71GurRy43WQWQIRLjDbPwGcc5RhRN
         lJdNaCKIdJ5iOlLiuhvDtIAV8+S11t++e/wprhTlft2YGTAdwj3S212c3Kw8LKBMX/x6
         bjfH78m62U4lKrRYcvl045GJnJ6L8Y15UMmpjdOxaSJhAZnwYy9jVhd2/Aa3b0Y33K6E
         WzKA==
X-Gm-Message-State: APjAAAXHRsOZQXXp+nW+fOAWv+r5osc0jmVNuWRgPih+yPIk4Z4KUTEW
        HXq3jcaqcSnDKLChsxySbjIaRw==
X-Google-Smtp-Source: APXvYqz31rz+Y/wBL1n2WlHHD8+319EA1rEWjpp+7w3FABkyrQZIK9hMRW/hmx73ZyR1/K9hsRw2gQ==
X-Received: by 2002:a05:6214:80c:: with SMTP id df12mr14254868qvb.113.1581987472267;
        Mon, 17 Feb 2020 16:57:52 -0800 (PST)
Received: from elrond.bobcopeland.com (CPE30b5c2fb365b-CMa456cc3dfbbf.cpe.net.cable.rogers.com. [99.232.51.173])
        by smtp.gmail.com with ESMTPSA id p2sm1130918qkg.102.2020.02.17.16.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 16:57:51 -0800 (PST)
Received: by elrond.bobcopeland.com (Postfix, from userid 1000)
        id 93F70FC0086; Mon, 17 Feb 2020 19:57:50 -0500 (EST)
Date:   Mon, 17 Feb 2020 19:57:50 -0500
From:   Bob Copeland <me@bobcopeland.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        linux-karma-devel@lists.sourceforge.net
Subject: Re: [PATCH 30/44] docs: filesystems: convert omfs.txt to ReST
Message-ID: <20200218005750.GB20689@bobcopeland.com>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
 <0c125c7c971d81a557ca954992b8d770a9d1e3e8.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c125c7c971d81a557ca954992b8d770a9d1e3e8.1581955849.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:12:16PM +0100, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document title;
> - Mark literal blocks as such;
> - Add table markups;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Bob Copeland <me@bobcopeland.com>

-- 
Bob Copeland %% https://bobcopeland.com/
