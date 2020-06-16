Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710031FC276
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 01:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFPXz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 19:55:26 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14510 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgFPXzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 19:55:25 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200616235523epoutp010e00aa6332025f8007f40a38c3a2d548~ZK3SrBicX0504205042epoutp01e
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 23:55:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200616235523epoutp010e00aa6332025f8007f40a38c3a2d548~ZK3SrBicX0504205042epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592351723;
        bh=4sYeuz6oTyLESXYSHQYd1K6SYgV3Ls6fZ7EpG0pJeps=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=F9a7/MkQPlg3eS1Z7j7+r91xeScwzC+Z+Ck9pR3bprEncc0AIMWLYX6zObosyKCL+
         thd+anpsqwDsYoKkWuYco3nzSa1ZR1uRLAk/ADks38wb06gwlL8gMQX92QMR8+C9jv
         NV+K6P77x+P0ac7eeq6P+n6ePHvaYgy6Jgu4GvYA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200616235522epcas1p3a5e6bad98ad3ab436708af0228225d5a~ZK3STCd2W1844018440epcas1p3k;
        Tue, 16 Jun 2020 23:55:22 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49mlST6lxRzMqYkV; Tue, 16 Jun
        2020 23:55:21 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.A4.18978.9EB59EE5; Wed, 17 Jun 2020 08:55:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200616235521epcas1p4ef4e7efcbba7993ac48cd591847242f3~ZK3Qz-73w1469514695epcas1p4W;
        Tue, 16 Jun 2020 23:55:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200616235521epsmtrp224b573225d469cefc46781246e610619~ZK3QwNfOt1745117451epsmtrp2a;
        Tue, 16 Jun 2020 23:55:21 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-0e-5ee95be9406a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.1E.08303.9EB59EE5; Wed, 17 Jun 2020 08:55:21 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200616235521epsmtip21a1734ccd7807787c6e4ced0577a59bc~ZK3Qk5b5v1384013840epsmtip2W;
        Tue, 16 Jun 2020 23:55:21 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200616021808.5222-1-kohada.t2@gmail.com>
Subject: RE: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
Date:   Wed, 17 Jun 2020 08:55:21 +0900
Message-ID: <000001d64439$98345740$c89d05c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHQ7uoMIC2a8IFxA0TaCcr40cOytAJGtMGMqNRTlqA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmvu7L6JdxBmeazSx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBaVY5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
        lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK
        0MDAyBSoMiEn4+MK44ITbBU9i08wNjBuYO1i5OSQEDCR+Pivi72LkYtDSGAHo8Spt++hnE+M
        EkdW/mGCcD4zSuy/0MMM03Lk8zQWiMQuRom7W08wQjgvGSWObuhkA6liE9CV+PdnP5gtIqAn
        cfLkdTaQImaBRiaJ5Se+gI3iFLCQ6H39BMjm4BAWsJRYeF0ZJMwioCpx+kgjC4jNCxQ+PmcH
        G4QtKHFy5hOwOLOAvMT2t3OgLlKQ+Pl0GSvELiuJ71+3MUHUiEjM7mxjBtkrITCXQ6JjeRMT
        RIOLxPcj3xghbGGJV8e3sEPYUhKf3+1lA7lHQqBa4uN+qPkdjBIvvttC2MYSN9eDAo8DaL6m
        xPpd+hBhRYmdv+cyQqzlk3j3tYcVYgqvREebEESJqkTfpcNQB0hLdLV/YJ/AqDQLyWOzkDw2
        C8kDsxCWLWBkWcUollpQnJueWmxYYIgc15sYwclUy3QH48S3H/QOMTJxMB5ilOBgVhLhdf79
        Ik6INyWxsiq1KD++qDQntfgQoykwqCcyS4km5wPTeV5JvKGpkbGxsYWJmbmZqbGSOK+4zIU4
        IYH0xJLU7NTUgtQimD4mDk6pBqY75Xnd3RuneDqJ3VJZMzvz2z5u7cslcoZbVxxqLbedu8tq
        CX9FFGN+G4fmEbWw12elFaa8YDp19GqM8wStRv6lC39GcDvyv77CLn+n+MBGx8VHf/ks+Ds/
        mX3K1hmKa93b47y6Sow41DkSxY68Wb9HbetKvQ8rpcMcz+9W0zZfEMRnLv/C6YOQYK1/1Acu
        Z24Wv/6VT441PRM3ru645Klzsch+94tVszlY4rPSw1aGtQk8U8vOPX5L9YbhvFd/Gl8+Cmc9
        wJN3XivT3CbZS6g3d468xoTbJ1zb+47vVl8v9cgn8Or/xI/LX01oD3ZI0PmwainHpkaN2Zle
        SRuz996ovJdhwyAmblZ+7oGOohJLcUaioRZzUXEiAFjwmdwvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXvdl9Ms4g9+zeC1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsdjy7wirA7vHlznH2T3aJv9j92g+tpLNY+esu+wefVtW
        MXp83iQXwBbFZZOSmpNZllqkb5fAlfFxhXHBCbaKnsUnGBsYN7B2MXJySAiYSBz5PI2li5GL
        Q0hgB6PE6vtvGSES0hLHTpxh7mLkALKFJQ4fLoaoec4o8ejuDLAaNgFdiX9/9rOB2CICehIn
        T15nAyliFmhmkvj2bAkzREcno8Tsqe0sIFWcAhYSva+fgE0VFrCUWHhdGSTMIqAqcfpII1gJ
        L1D4+JwdbBC2oMTJmU9YQMqZgRa0bQTbyywgL7H97RxmiDsVJH4+XcYKcYOVxPev25ggakQk
        Zne2MU9gFJ6FZNIshEmzkEyahaRjASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M
        4JjS0trBuGfVB71DjEwcjIcYJTiYlUR4nX+/iBPiTUmsrEotyo8vKs1JLT7EKM3BoiTO+3XW
        wjghgfTEktTs1NSC1CKYLBMHp1QDk7X4EsF/sr+90+bmBr7Izz/1oaNQ/cV3jj/l0vUrbvDI
        vWuNMcubIWla5+eTn+lfHlBedUJC8/4icQeVF/d4zeqW/Zsx6+C511fMH95xvF3wI/xeeIDj
        z3Pz0z8KW00qNeyJepDw6qpp/szEX/9ef3CKOXWw08en3Xs6y1WFjbPnvN49m2f612tSQnt/
        bdt0TEJm9WMOibk5PepGjowbMhY9UXCZXeJ4LXOfSMbie26/yh0TN36d8sN474yMzc/aftz1
        4L1ZFbPh/BR5pT/M/B/Dlb6oZrWZ7XCWFje/e8jk6Jz8xb2Wv33rup0zJ5yLzJMrOtzklCnw
        JXfOktNlJzJTml0seK0Ysxcd9XM6oMRSnJFoqMVcVJwIAIYgz4YYAwAA
X-CMS-MailID: 20200616235521epcas1p4ef4e7efcbba7993ac48cd591847242f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200616021816epcas1p44b0833f14bbad0e25cc0efb27fb2ebd3
References: <CGME20200616021816epcas1p44b0833f14bbad0e25cc0efb27fb2ebd3@epcas1p4.samsung.com>
        <20200616021808.5222-1-kohada.t2@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> remove EXFAT_SB_DIRTY flag and related codes.
> 
> This flag is set/reset in exfat_put_super()/exfat_sync_fs() to avoid sync_blockdev().
> However ...
> - exfat_put_super():
> Before calling this, the VFS has already called sync_filesystem(), so sync is never performed here.
> - exfat_sync_fs():
> After calling this, the VFS calls sync_blockdev(), so, it is meaningless to check EXFAT_SB_DIRTY or to
> bypass sync_blockdev() here.
> Not only that, but in some cases can't clear VOL_DIRTY.
> ex:
> VOL_DIRTY is set when rmdir starts, but when non-empty-dir is detected, return error without setting
> EXFAT_SB_DIRTY.
> If performe 'sync' in this state, VOL_DIRTY will not be cleared.
There is still a problem if system reboot or device is unplugged when sync is not called yet.
I will remove this mention in the patch.

