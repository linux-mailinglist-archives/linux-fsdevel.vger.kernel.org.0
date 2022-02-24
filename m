Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7034C3C96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 04:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiBYDph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 22:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbiBYDpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:45:34 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE8A2692B1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 19:44:58 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220225034456epoutp032b5b51b1af5e21716d2961ee6ddd76e9~W6qJMieak2903529035epoutp03k
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 03:44:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220225034456epoutp032b5b51b1af5e21716d2961ee6ddd76e9~W6qJMieak2903529035epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645760696;
        bh=/UO9eDeRsnQ02mI7zvtYj8GHrR3f9M5BXxxiPQPbV80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JefR7KCdoc8VYZ/gaDGHtpQ93aksxuZB3AltK9ZrzS4COccgFleZ2IgUqiU5g/XYZ
         llyjEm/q+BSxGEao4yH9oPfQU6vaOH72a4ytEYQwrlR8PlIrQZxQvZiMGZFBBhVwCt
         4iLRXVnfztS7zF7tGnpVqfhKyKRzzcux+8UqDOn4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220225034455epcas5p26a20b70a651c5c4813b20d1e48f2ba38~W6qIW7Vke0148301483epcas5p2P;
        Fri, 25 Feb 2022 03:44:55 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4K4bJ31YBBz4x9Px; Fri, 25 Feb
        2022 03:44:51 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.C9.06423.9A058126; Fri, 25 Feb 2022 12:44:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220224124713epcas5p17e353eef4fb4990f0442bc0614217227~WuaVbgzqc2876728767epcas5p15;
        Thu, 24 Feb 2022 12:47:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220224124713epsmtrp2ee80afa62db594176e0e55aba7521d29~WuaVZNiVv0741907419epsmtrp2H;
        Thu, 24 Feb 2022 12:47:13 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-22-621850a9e292
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.83.29871.15E77126; Thu, 24 Feb 2022 21:47:13 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220224124709epsmtip22be20cc572111b6fe3937746e483cc64~WuaR4KTdj1429314293epsmtip2W;
        Thu, 24 Feb 2022 12:47:09 +0000 (GMT)
Date:   Thu, 24 Feb 2022 18:12:13 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        zach.brown@ni.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com
Subject: Re: [PATCH v2 08/10] dm: Add support for copy offload.
Message-ID: <20220224124213.GD9117@test-zns>
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2202160845210.22021@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHPfe2txe2sgtCOHYwu+qcqBQqDw+LDBN0u5NJGCxjc3FY4IYS
        Stu0ZRvbxEIhCohIGbPAAsSBBJCJzPCuCo4wBAyMlzIfMECUlzwmg4iylpbF/z6/7/l+f+ec
        38khcbtaDo+MlqkZpUwsFRDWrJqbLjtdy4JguPvFaifUdHeRjSruZxLop7kVHD1tHmUjXaae
        g3rHbJBhNp+NupcTMTRavYahpgs6DJVVtGJoovQXgFI7ujG0OiJCrWszBNK1DABkGNqNmgzt
        LFR4cZyD0gfrCHRtyoCj0raXGMo63Y+h23mrBLr5oJ+FKlYRSjmzwkGT17864ET39gXQWdpZ
        Dq0tuseie7vi6OryVIL+rfgknX2nFNCNdzUEndTZitP6hX8IerCzFqMztLMEPT8+xKJrRjI4
        9NNr/QR99mo5CLI/GrNfwogjGSWfkUXII6NlUb6CgJAw/zAvb3eRq8gH7RPwZeJYxldw8OMg
        1w+ipcb5CPhfi6VxRilIrFIJ3N7fr5THqRm+RK5S+woYRaRU4akQqsSxqjhZlFDGqN8Tubvv
        9TIaj8dI9IX5hGLutW/L12ZZGjBslQasSEh5wtTkK3gasCbtqEYAl3MGOeZiAcD56ny2uVgC
        sGS6gL0ReZyYaHEZACzUbuQfAViZVIibXCzqHbhWWmZMkCRB7YYda6RJtqdc4J8/T693xakh
        FtQPjnBMC5spP5iyXLnu51J7YP7tfSaZS9nC9twxlomtqC9hT3bSOjtQ2+CNmjbM1AdSf1vB
        56VduPl0B2HeTC3HzJvhZNtVC/Pg4qyBMAfSjRftfGhJ6wHUntMSZpcf7Gl6gZkYpySwPnfZ
        knaGObd+teg2MOP5GGbWubCuYIO3wUuXiyx9tsCBfxMtTMOugReWQfZjcPxSDXEObM175Xp5
        r+xn5j2wqHGByDNOA6fehKUvSTO6wMsNbkWAXQ62MApVbBSj8lKIZMw3/795hDy2Gqz/oF0f
        1YH7w3PCFoCRoAVAEhfYc0dPOIbbcSPF8d8xSnmYMk7KqFqAl/G1snCeQ4Tc+AVl6jCRp4+7
        p7e3t6ePh7dI4MjtiKoS21FRYjUTwzAKRrmRw0grngb7vim44Nlhh5lNkpPVy4tdQ0fC39bU
        Vcyzy/x5xVd+rPyMHMvzCPV7qww4f5F67K+SUxUrtavRwY+SNSE2Hk47HlhnvhESmLYpfqq9
        JKZYZ5OZuzLhc+yH7fIbRw9P+iz87uoRv5iTIDTY3nOK1tpmR/g69JGC+ltVd6rCCkLttzZr
        Pm1IlYghKyPpyYdnNWqH84su+sejBzbxczo0oER++pTOOuW6UFAXKnJOiB14knyI07Dj4fmI
        pHcDhMfx4cDF7J1/uDS/nrwUFHgBtC/0HAmdomB6Pe32bODzib5pXa+ddPsJ5pOEejJ4SaFr
        3uvfPXBmitcZ4jznODTtqq+05c8LWCqJWLQLV6rE/wGLOMDxygQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7bCSvG5gnXiSQcd3RYs9Nz+zWqy+289m
        Me3DT2aL9wcfs1pM6p/BbnH5CZ/F3nezWS0u/Ghksni86T+TxZ5Fk5gsVq4+ymTxfPliRovO
        0xeYLP48NLQ4+v8tm8WkQ9cYLfbe0rbYs/cki8X8ZU/ZLbqv72Cz2Pd6L7PF8uP/mCwmdlxl
        sjg36w+bxeF7V1ksVv+xsGjt+clu8Wp/nIOMx+Ur3h4Tm9+xezQvuMPicflsqcemVZ1sHpuX
        1HtMvrGc0WP3zQY2j6YzR5k9Znz6wuZx/cx2Jo/e5ndsHh+f3mLx2Pawl93j/b6rbB59W1Yx
        BohEcdmkpOZklqUW6dslcGWs77zAXLCBs+LWSssGxp3sXYycHBICJhIvGhvBbCGB3YwSUz7r
        Q8QlJZb9PcIMYQtLrPz3HKiGC6jmCaPEyXdPmEASLAKqEv+Xr2TtYuTgYBPQljj9nwMkLCKg
        KXFpzhtWkHpmgTssErv+PAMbJCxgL9H6Yy1YPa+AjsTsc+YQM68ySWzcPIMRpIZXQFDi5Mwn
        LCA2s4CWxI1/L5lA6pkFpCWW/wObzykQLXFxchNYiaiAssSBbceZJjAKzkLSPQtJ9yyE7gWM
        zKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYIThpbmDsbtqz7oHWJk4mA8xCjBwawk
        wmtaKJYkxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA1Nt
        Rhj70op5z0xtc6esmRqwSjwgbqXToigz7esFRfMLY3ddqhN4kfC4L+T/MkUjW5GwS4c5Td2X
        bqxtY6413Bx5a7WgwUvdb6sfM98L3dgUbn/g/YXXfAWT3kzKe35tu5+27S/d0zclvzi/Eg1R
        dji5VrU+2Nbc+4Fawv73pyVPu97awP/lYH0RA8vVD5uMM2ZVzD3/IqWnepOsWkeM7OnrMco8
        OjzhOfnHFzWmPrPzFFypedbRa2+l8eU/7309zA683Dqh64bofvlLi5fxfvKQiDPLtjHtrvvu
        al5VuvPVG69VEhOKgx+rars5FFfxT1566u+8t7q3C4y/TPZ/fPx84MM9s4KkHuxdyT5F0FyJ
        pTgj0VCLuag4EQCXTrmYhwMAAA==
X-CMS-MailID: 20220224124713epcas5p17e353eef4fb4990f0442bc0614217227
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_b2668_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141948epcas5p4534f6bdc5a1e2e676d7d09c04f8b4a5b
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <20220207141348.4235-1-nj.shetty@samsung.com>
        <CGME20220207141948epcas5p4534f6bdc5a1e2e676d7d09c04f8b4a5b@epcas5p4.samsung.com>
        <20220207141348.4235-9-nj.shetty@samsung.com>
        <alpine.LRH.2.02.2202160845210.22021@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_b2668_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Feb 16, 2022 at 08:51:08AM -0500, Mikulas Patocka wrote:
> 
> 
> On Mon, 7 Feb 2022, Nitesh Shetty wrote:
> 
> > Before enabling copy for dm target, check if underlaying devices and
> > dm target support copy. Avoid split happening inside dm target.
> > Fail early if the request needs split, currently spliting copy
> > request is not supported
> > 
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> 
> If a dm device is reconfigured, you must invalidate all the copy tokens 
> that are in flight, otherwise they would copy stale data.
> 
> I suggest that you create a global variable "atomic64_t dm_changed".
> In nvme_setup_copy_read you copy this variable to the token.
> In nvme_setup_copy_write you compare the variable with the value in the 
> token and fail if there is mismatch.
> In dm.c:__bind you increase the variable, so that all the tokens will be 
> invalidated if a dm table is changed.
> 
> Mikulas
> 
>
Yes, you are right about the reconfiguration of dm device. But wouldn't having a
single global counter(dm_changed), will invalidate for all in-flight copy IO's
across all dm devices. Is my understanding correct?

--
Nitesh Shetty

------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_b2668_
Content-Type: text/plain; charset="utf-8"


------.rW42XXn7_Ji6OxwuAF4RAMbP.qed.OeqKlvEhSLhB3noATS=_b2668_--
