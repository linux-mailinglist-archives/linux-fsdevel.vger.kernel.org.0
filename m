Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBCE1B1A28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 01:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDTX3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 19:29:00 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14354 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgDTX3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:29:00 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200420232857epoutp01fb0baf48b5230d390db15ef4c3ab1b28~Hqu8VmtEO2662426624epoutp01Y
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 23:28:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200420232857epoutp01fb0baf48b5230d390db15ef4c3ab1b28~Hqu8VmtEO2662426624epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587425337;
        bh=rtTGpl+Ynpi62GeJ7ZIOM1Wx8xmCKRYY24lO8MwojUc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=BmS46vlyMxG6Cc6CGSswomkQS9qlKJZZUMCwgTEv5FbQcYTKn0hZPVv6ipU27g+vJ
         K3lNA3PggFn6OK2LeWtgpQ6WWEUMlTiG5kWCjb4LG0WQo9OwjAbO5ORgrltNVAdX9U
         yHXTjtVjfDNXzXT6jEBWC7Wsu6Z39MMn8xtfwF54=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200420232857epcas1p1b2da87be66efe15f5c4c043e0816b61f~Hqu8KcEWR1144911449epcas1p1-;
        Mon, 20 Apr 2020 23:28:57 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.166]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 495jZJ4nM2zMqYkV; Mon, 20 Apr
        2020 23:28:56 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.96.04544.8303E9E5; Tue, 21 Apr 2020 08:28:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200420232855epcas1p318ad5a43a185f94c659629befb01d1ca~Hqu60gJtJ2745927459epcas1p3V;
        Mon, 20 Apr 2020 23:28:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200420232855epsmtrp26284d52e8939638371625c7b094f92de~Hqu6z3CwI3146331463epsmtrp2J;
        Mon, 20 Apr 2020 23:28:55 +0000 (GMT)
X-AuditID: b6c32a36-7ffff700000011c0-d9-5e9e3038f901
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.2A.04158.7303E9E5; Tue, 21 Apr 2020 08:28:55 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200420232855epsmtip12639838838613ddea4dd45e462e6c1a4~Hqu6m6BHY1870318703epsmtip1S;
        Mon, 20 Apr 2020 23:28:55 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Matthew Wilcox'" <willy@infradead.org>
Cc:     "'fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'Eric Sandeen'" <sandeen@sandeen.net>
In-Reply-To: <20200419031554.GU5820@bombadil.infradead.org>
Subject: RE: [PATCH 1/2] exfat: properly set s_time_gran
Date:   Tue, 21 Apr 2020 08:28:55 +0900
Message-ID: <000001d6176b$75a5ada0$60f108e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFv9ZU26a8Upqtysk0gAvfIf9DAALAtF5iAaMl6OoCp0DtKabq+95g
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTT9fCYF6cwfKbKhZ79p5ksWi9omXx
        +8ccNgdmj80rtDy2LH7I5PF5k1wAc1SOTUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGl
        hbmSQl5ibqqtkotPgK5bZg7QGiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgaFB
        gV5xYm5xaV66XnJ+rpWhgYGRKVBlQk7G2qm9jAW7GCu+rp7I2MDYy9jFyMkhIWAise9lH1sX
        IxeHkMAORonfnVsYIZxPjBJrr52FynxjlDi35g47TMvztj3MEIm9jBIdRy+zgiSEBF4ySuyY
        pQ9iswnoSvz7s58NxBYR0JHoerkdrIZZIFLi/rNHLCA2p4C1xM2v3UA2B4ewgIXE779gYRYB
        VYmfu5+AtfIKWEqsfPcHyhaUODnzCQvEGHmJ7W/nMEPcoyDx8+kyVpAxIgJuEodnqUOUiEjM
        7mwDO1NCYAebxMXDV9lAaiQEXCRajmtDtApLvDq+BeotKYnP7/ZClVRLfNwPNb2DUeLFd1sI
        21ji5voNYJuYBTQl1u/ShwgrSuz8PZcRYiufxLuvPawQU3glOtqEIEpUJfouHWaCsKUluto/
        sE9gVJqF5K1ZSN6aheT+WQjLFjCyrGIUSy0ozk1PLTYsMEKO6E2M4OSnZbaDcdE5n0OMAhyM
        Sjy8G8TmxQmxJpYVV+YeYpTgYFYS4bXQAgrxpiRWVqUW5ccXleakFh9iNAWG+kRmKdHkfGBi
        ziuJNzQ1MjY2tjAxMzczNVYS5516PSdOSCA9sSQ1OzW1ILUIpo+Jg1OqgbGNvbtne6/EqiB/
        ySP6qrc3zK+vm/QjU2LB8YTwSyztb370hfs9/Vf4eeEJhzkzfrCaiv1U86jZ0Syz4PysxfJm
        TrX+10X8As9tfGlyzqLvx/Zpk+Yc/uexXimTwW2H+LeWnU8Uo0+UrzfLkw7NK1/B63DH588M
        14Nxqj7a82wsqi88C3ZNC1RiKc5INNRiLipOBADCEXlalAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnK65wbw4gxU39Cz27D3JYtF6Rcvi
        9485bA7MHptXaHlsWfyQyePzJrkA5igum5TUnMyy1CJ9uwSujLVTexkLdjFWfF09kbGBsZex
        i5GTQ0LAROJ52x7mLkYuDiGB3YwSNw5tYYFISEscO3EGKMEBZAtLHD5cDFHznFGib9I6sGY2
        AV2Jf3/2s4HYIgI6El0vt7OC2MwCkRIHnvyHGvqJUeLKnBdgQzkFrCVufu1mARkqLGAh8fsv
        WJhFQFXi5+4nYHN4BSwlVr77A2ULSpyc+QSsnFlAT6JtIyPEeHmJ7W/nMEOcqSDx8+kyVpAS
        EQE3icOz1CFKRCRmd7YxT2AUnoVk0CyEQbOQDJqFpGMBI8sqRsnUguLc9NxiwwKjvNRyveLE
        3OLSvHS95PzcTYzgONDS2sF44kT8IUYBDkYlHt4NYvPihFgTy4orcw8xSnAwK4nwWmgBhXhT
        EiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTCKzvzdPTVR+Lzt
        rNOn5PftZOYUlXqovjL9lMwx7mTXJ27p279OP716SpaVlt9mE77LPFrqpvPXG5tyNwn8LYie
        NIfn1qt7783ucygcemXF5H6s6XaHb++zyRdErt1o2787ozUygWGv/cZVLovfy9sfsrtVwvVw
        m3l6cWES3zufqAVJm9/f3zZNiaU4I9FQi7moOBEA6Aj4f38CAAA=
X-CMS-MailID: 20200420232855epcas1p318ad5a43a185f94c659629befb01d1ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200419031558epcas1p354b0e2f83f5d386101bfcb443be46691
References: <ef3cdac4-9967-a225-fb04-4dbb4c7037a9@sandeen.net>
        <5535c58b-aac1-274e-a0bb-6333b33365d1@sandeen.net>
        <CGME20200419031558epcas1p354b0e2f83f5d386101bfcb443be46691@epcas1p3.samsung.com>
        <20200419031554.GU5820@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> On Wed, Apr 15, 2020 at 08:09:11PM -0500, Eric Sandeen wrote:
> > -	sb->s_time_gran = 1;
> > +	sb->s_time_gran = 10000000;
> 
> 10 * NSEC_PER_MSEC?
Looks cleaner.
Thanks!

