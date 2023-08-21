Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19752782301
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjHUEyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHUEyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:54:45 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 031D9A3;
        Sun, 20 Aug 2023 21:54:41 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-91-64e2ee0f13f7
Date:   Mon, 21 Aug 2023 13:51:36 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
        torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: Re: [RESEND PATCH v10 25/25] dept: Track the potential waits of
 PG_{locked,writeback}
Message-ID: <20230821045136.GB73328@system.software.com>
References: <20230821034637.34630-1-byungchul@sk.com>
 <20230821034637.34630-26-byungchul@sk.com>
 <ZOLnRSdH4Wcrl67L@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOLnRSdH4Wcrl67L@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH9zz39rm3nXXX6rJHWDbt4rZgJi9xyYkuy7LE7Vm2JSa6D7oP
        0K030lDQFEUgMcFZFXmtJsCo3VJgK4gVtRDFabWAUpgOmCBWBDI6NkFaSMCi5c21c2Z+Ofnl
        /HN++X84IqfJIzGiIWOvbMrQGbVExauCy6ree2XSr0/4yxcPx4sSIPQonwfbWSeBnobTCJxN
        BzGM3/gU7s4GEMz/1s1BRVkPgqqRIQ6a2ocRuOu+I9A7uhz6QlMEOssKCRyqOUvg94kFDIPl
        JzCcdn0JNy3VGDzhBzxUjBM4WXEIR8YYhrCjXgBH3jrw11kFWBhJhM7hfgW4B9ZD5Y+DBK64
        O3lob/Zj6P3FRmDY+VQBN9s7eOg5XqyAM5PVBCZmHRw4QlMC3PbYMZwzR0RHZpYU4C32YDjy
        03kMffcuI7ia/wcGl7OfQFsogKHRVcbBXO0NBP6SoACHi8ICnDxYgqDwcDkP3YteBZgH34f5
        Jzby0SbWFpjimLlxP3PP2nn2azVll6xDAjNfHRCY3bWPNdbFsZor45hVTYcUzFV/jDDX9AmB
        FQT7MJvs6hJYx/fzPBvtq8BbY3eqPtDLRkOWbIr/MEWVeid4it+zoM4eaJ7m8tCcqgApRSpt
        pI+8XvKcba3HhCjz0jpqu1jDR5lI71CfL8wVIFFcJb1LA01J0TUndahoqS03yiulFBqeKVVE
        WS0BvXs0FGGVqJGKEP178fF/wQraWTnKPzuOo76lcRx1clIsrV0So2tlpILVEfi3zqvSW9Rz
        wYujHiq1Kelg2IKf9VxNW+p8vAVJ1he01he01v+1dsTVI40hIytdZzBu3JCak2HI3vDt7nQX
        ivyl48DC181oumdbK5JEpF2mTnndr9codFmZOemtiIqcdpU69vGIXqPW63JyZdPuZNM+o5zZ
        imJFXvuaOml2v14j7dLtldNkeY9sep5iURmTh/Iv1qaVin+uuZYbszz+i13a5C3dQ1NHP37w
        5Kn9K7tmDTemtWy+ntiwZfumYqOzqn+s5WffkvzyaBJrKekvfOlhsOz+/Vvw5uffxLy94t6l
        ys/WX+tdO+MVCs7P+Q8kb+VIua6w4eEPOy5f6DKMrZ0wJ2TP5O5M039icb9x3X5KuXjOo+Uz
        U3WJcZwpU/cPbz3LRJMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUyTZxSGfZ73k2ad7zqMT4A/62LcWKYyJTkJC5kZCU+mW/bDuYVp7Ov6
        ZjQU0FaZkJngAFFEBLdaqZ0psBTEbs5CHH5gmiKFClMUVMawGx2bYxbYwOIqBddmM/PPyZVz
        57pzfhyR0QS5JNFQsEsxFchGLa9iVe9klL26dCqoX9PavBTqqtdA+MEBFuxnXDwMfHMagat9
        H4aJ7my4MxdCMP/9dQaslgEEDWN3GWj3BRB0tnzGw+D4szAUnubBbznEQ1nTGR5u3I9iGD12
        FMNp99vQV9uIwRO5x4J1gocT1jIcG79jiDhbBXCWroBgi02A6Fga+AO3Oej60s9B58grUH9y
        lIdLnX4WfB1BDIMX7DwEXI856PP1sjBQd5iDr6caebg/52TAGZ4W4KbHgeHb8ljb/tlFDnoO
        ezDs/+oshqEfLiK4fOBnDG7XbR66wiEMbW4LA4+auxEEayYFqKiOCHBiXw2CQxXHWLi+0MNB
        +Wg6zP9t59/IoF2haYaWt31CO+ccLL3aSOh5212Bll8eEajDvZu2taTSpksTmDbMhDnqbj3I
        U/fMUYFWTQ5hOnXtmkB7j8+zdHzIit9NyVG9rleMhiLFtDpTp8q9NXmK3RFV7xnpmGFK0SNV
        FUoQibSO2L0HhTiz0gpi/66JjTMvrSTDwxGmColiovQSCbW/Fl8zUq+KHLGXxPl5SUcis0e4
        OKslIHcqwzFWiRqpGpHfFh7+FzxH/PXj7L9yKhlenMDxTkZKJs2LYnydEDvB5gzxcV4mvUg8
        53pwLVLbnrJtT9m2/20HYlpRoqGgKF82GNNXmfNyiwsMe1Z9VJjvRrHPc+6N1nWgB4PZXiSJ
        SPuMWpcS1Gs4uchcnO9FRGS0ierkh2N6jVovF5copsJtpt1GxexFySKrXa5+631Fp5E+lncp
        eYqyQzE9SbGYkFSKlst+3ctrnasTgvXGYNSbkrRZ9lW2RAKWQE7apiUv7N346+jZ0kz6Re2W
        gPWPtdu3/tT/ecbxbDus78hMG/nxlGND5rLHuor+bSunTecq+z4sPN+vajCVrKshH/wyJvz5
        3vadliyblIjSPxWLXFfu/eULZOW9SYpzZ9cv2LI8ge4BLWvOldNSGZNZ/gfo2omcdQMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 21, 2023 at 05:25:41AM +0100, Matthew Wilcox wrote:
> On Mon, Aug 21, 2023 at 12:46:37PM +0900, Byungchul Park wrote:
> > @@ -377,44 +421,88 @@ static __always_inline int Page##uname(struct page *page)		\
> >  #define SETPAGEFLAG(uname, lname, policy)				\
> >  static __always_inline						\
> >  void folio_set_##lname(struct folio *folio)			\
> > -{ set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
> > +{									\
> > +	set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy));	\
> > +	dept_page_set_bit(&folio->page, PG_##lname);			\
> 
> The PG_locked and PG_writeback bits only actually exist in the folio;
> the ones in struct page are just legacy and never actually used.
> Perhaps we could make the APIs more folio-based and less page-based?

Yeah. I need to make it more folio-based. I will work on it. Thank you.

> >  static __always_inline void SetPage##uname(struct page *page)	\
> > -{ set_bit(PG_##lname, &policy(page, 1)->flags); }
> > +{									\
> > +	set_bit(PG_##lname, &policy(page, 1)->flags);			\
> > +	dept_page_set_bit(page, PG_##lname);				\
> > +}
> 
> I don't think we ever call this for PG_writeback or PG_locked.  If
> I'm wrong, we can probably fix that ;-)

Okay then, I will assume this will never be used. So are you asking me
to get rid of this part, right?

> >  static __always_inline void __SetPage##uname(struct page *page)	\
> > -{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
> > +{									\
> > +	__set_bit(PG_##lname, &policy(page, 1)->flags);			\
> > +	dept_page_set_bit(page, PG_##lname);				\
> > +}
> 
> Umm.  We do call __SetPageLocked() though ... I'll fix those up to
> be __set_folio_locked().

Haha Okay. Lemme know when you get done on it. Thanks.

	Byungchul
