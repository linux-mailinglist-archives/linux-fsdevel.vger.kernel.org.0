Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5FAC13BB9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAOI5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:57:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgAOI5C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:57:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 192B32187F;
        Wed, 15 Jan 2020 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579078621;
        bh=3WyxfmsLcZdvCzfHJIln9D0EDXYaykJoZ9k/zJOeSB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3SIvNz7CwaoCb5Yj3vfmJTDPIopA/8P8ESTsDX1eqkWf0EN4sYhs5/BzaHi7Rn/x
         Mn/alJUvEWJNULn/47olE6wc4Qc/cBJy/WJSgdsQCajDvfqGOgbm8ZkQzu/3cihk75
         8P145i3DzJtqQvk5pb7BjVVqcaEgdgMdtYRaUKSU=
Date:   Wed, 15 Jan 2020 09:56:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        valdis.kletnieks@vt.edu, hch@lst.de, sj1557.seo@samsung.com,
        linkinjeon@gmail.com, pali.rohar@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 14/14] staging: exfat: make staging/exfat and
 fs/exfat mutually exclusive
Message-ID: <20200115085658.GA3045123@kroah.com>
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
 <CGME20200115082826epcas1p3475ce2b4d03234dc96ced428be582eb3@epcas1p3.samsung.com>
 <20200115082447.19520-15-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115082447.19520-15-namjae.jeon@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 05:24:47PM +0900, Namjae Jeon wrote:
> Make staging/exfat and fs/exfat mutually exclusive to select the one
> between two same filesystem.
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
